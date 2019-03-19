defmodule SimpleServer.Router do
  use Plug.Router
  use Plug.Debugger
  require Logger
  # plug Plug.Session, store: :cookie,
  #   key: "_elx_simple_api_session",
  #   encryption_salt: "elxsimpleapienc",
  #   signing_salt: "elxsimpleapisign",
  #   log: :debug
  # plug :fetch_session
  # plug Plug.CSRFProtection

  plug(Plug.Logger, log: :debug)

  plug(:match)

  plug(Plug.Parsers, parsers: [:urlencoded, :multipart])

  plug(:dispatch)

  get "/hello" do
    send_resp(conn, 200, "world")
  end

  post "/upload" do
    file = Map.get(conn.body_params, "file")
    # %{path: path, filename: filename, content_type: content_type} = file
    stringified = Poison.encode!(conn.body_params)
    IO.inspect stringified
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, stringified)
  end
  
  get _ do
    send_resp(conn, 404, "not found")
  end
end
