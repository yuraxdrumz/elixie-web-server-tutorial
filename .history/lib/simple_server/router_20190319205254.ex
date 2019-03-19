defmodule SimpleServer.Router do
  use Plug.Router
  require Logger
  {:ok, mongo_conn} = Mongo.start_link!(url: "mongodb://localhost:27017/db-name")
  Logger.info "Connected to mongo"
  # plug Plug.Session, store: :cookie,
  #   key: "_elx_simple_api_session",
  #   encryption_salt: "elxsimpleapienc",
  #   signing_salt: "elxsimpleapisign",
  #   log: :debug
  # plug :fetch_session
  # plug Plug.CSRFProtection

  plug(Plug.Logger, log: :debug)
  plug(Plug.RequestId)
  plug(:match)
  plug(Plug.Parsers, parsers: [:urlencoded, :multipart, :json], json_decoder: Poison)

  plug(:dispatch)

  get "/hello" do
    Mongo.find(mongo_conn, "collection", %{})

    send_resp(conn, 200, "world")
  end

  post "/upload" do
    stringified = Poison.encode!(conn.body_params)
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, stringified)
  end
  
  get _ do
    send_resp(conn, 404, "not found")
  end
end
