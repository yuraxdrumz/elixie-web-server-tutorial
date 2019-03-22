defmodule SimpleServer.Router do
  use Plug.Router
  use Plug.ErrorHandler
  import SimpleServer.RegController
  alias SimpleServer.Validator
  # plug Plug.Session, store: :cookie,
  #   key: "_elx_simple_api_session",
  #   encryption_salt: "elxsimpleapienc",
  #   signing_salt: "elxsimpleapisign",
  #   log: :debug
  # plug :fetch_session
  # plug Plug.CSRFProtection
  plug(:match)
  plug(:fetch_query_params)
  plug(Plug.RequestId)
  plug(Plug.Parsers, parsers: [:urlencoded, :multipart, :json], json_decoder: Poison)
  # plug(Validator, [%{route: "/other/:s", qs: %{test: Integer}}])
  plug(:dispatch)
  
  get "/other/:s", do: handle_other(conn)

  post "/upload", do: handle_upload(conn)
  
  forward "/weather", to: SimpleServer.AuthRouter

  def handle_errors(conn, %{kind: kind, reason: reason, stack: _stack}) do
    send_resp(conn, conn.status, Poison.encode!(%{kind: kind, reason: reason}))
  end
  
  match _ do
    send_resp(conn, 404, "not found")
  end
end
