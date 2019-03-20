defmodule SimpleServer.Router do
  use Plug.Router
  use Plug.ErrorHandler
  require Logger
  # plug Plug.Session, store: :cookie,
  #   key: "_elx_simple_api_session",
  #   encryption_salt: "elxsimpleapienc",
  #   signing_salt: "elxsimpleapisign",
  #   log: :debug
  # plug :fetch_session
  # plug Plug.CSRFProtection

  plug(:match)
  plug(Plug.RequestId)
  plug(Plug.Parsers, parsers: [:urlencoded, :multipart, :json], json_decoder: Poison)
  plug(:dispatch)
  
  get "/other" do    
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, "ok")
  end

  post "/upload" do    
    stringified = Poison.encode!(conn.body_params)
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, stringified)
  end
  
  forward "/user", to: SimpleServer.AuthRouter

  # def handle_errors(conn, %{kind: kind, reason: reason, stack: _stack}) do
  #   send_resp(conn, conn.status, Poison.encode!(%{error: kind}))
  # end
  
  match _ do
    send_resp(conn, 404, "not found")
  end
end
