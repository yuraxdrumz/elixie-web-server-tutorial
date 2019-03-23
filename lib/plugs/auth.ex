defmodule SimpleServer.Authentication do
  import Plug.Conn
  use Joken.Config
  
  def init(opts) do
    opts
  end

  defp authenticate({conn, token}) do
    jwt = String.slice(token, 7, String.length(token))
    case verify_and_validate(jwt) do
      {:ok, claims} -> %{conn | assigns: Map.merge(conn.assigns, claims)}
      {:error, err} -> send_custom_resp(conn, %{error: err})
      _ -> send_custom_resp(conn)
    end
  end

  defp send_custom_resp(conn, data \\ %{message: "Please make sure you have authentication header"}) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(401, Poison.encode!(data))
    |> halt
  end

  defp authenticate({conn}) do
    send_custom_resp(conn)
  end

  defp get_auth_header(conn) do
    case get_req_header(conn, "authorization") do
      [token] -> {conn, token}
      _ -> {conn}
    end
  end

  def call(%Plug.Conn{request_path: _path} = conn,_opts) do
    conn
    |> get_auth_header
    |> authenticate
  end
end