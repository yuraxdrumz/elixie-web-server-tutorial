defmodule SimpleServer.Router do
  use Plug.Router
  use Plug.Debugger
  require Logger
  plug Plug.Session, store: :cookie,
    key: "_elx_simple_api_session",
    encryption_salt: "elxsimpleapienc",
    signing_salt: "elxsimpleapisign",
    log: :debug
  plug :fetch_session
  plug Plug.CSRFProtection
  defp put_csrf_token_in_session(conn, _) do
    Plug.CSRFProtection.get_csrf_token
    conn |> put_session("_csrf_token", Process.get(:plug_unmasked_csrf_token))
  end
  plug(Plug.Logger, log: :debug)

  plug(:match)

  plug(Plug.Parsers, parsers: [:urlencoded, :multipart])

  plug(:dispatch)


  # TODO: add routes!

  get "/hello" do
    send_resp(conn, 200, "world")
  end

  post "/upload" do
    send_resp(conn, 200, "application/json")
    
  end
  
  get _ do
    send_resp(conn, 404, "not found")
  end
end
