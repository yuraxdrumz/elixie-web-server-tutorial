defmodule SimpleServer.Authentication do
  import Plug.Conn
  use Joken.Config
  
  def init(opts), do: opts


  defp check_auth(conn, token) do 
    jwt = String.slice(token, 7, String.length(token))
    case SimpleServer.Authentication.verify_and_validate(jwt) do
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

  def call(conn, _opts) do
    case get_req_header(conn, "authorization") do
      [auth_str] -> check_auth(conn, auth_str)
      _ -> send_custom_resp(conn)
    end
  end
end