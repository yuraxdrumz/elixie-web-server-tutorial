defmodule SimpleServer.Router do
  use Plug.Router
  require Logger
  alias SimpleServer.Repo
  alias SimpleServer.Authentication
  # plug Plug.Session, store: :cookie,
  #   key: "_elx_simple_api_session",
  #   encryption_salt: "elxsimpleapienc",
  #   signing_salt: "elxsimpleapisign",
  #   log: :debug
  # plug :fetch_session
  # plug Plug.CSRFProtection
  plug Authentication
  plug(:match)
  plug(Plug.Logger, log: Application.get_env(:simple_server, :log_level))
  plug(Plug.RequestId)
  plug(Plug.Parsers, parsers: [:urlencoded, :multipart, :json], json_decoder: Poison)
  plug(:dispatch)

  get "/user/:user_id" do
    IO.inspect conn.assigns
    data = Repo.findPermissions |> Enum.to_list()  |> Poison.encode!
    send_resp(conn ,200, data)
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
  post _ do
    send_resp(conn, 404, "not found")
  end
end
