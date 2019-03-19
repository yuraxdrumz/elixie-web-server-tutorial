defmodule SimpleServer.Router do
  use Plug.Router
  use Plug.Debugger
  require Logger

  plug(Plug.Logger, log: :debug)

  plug(:match)

  plug(Plug.Parsers, parsers: [:urlencoded, :multipart])

  plug(:dispatch)


  # TODO: add routes!

  get "/hello" do
    send_resp(conn, 200, "world")
  end

  post "/upload" do
    %{"data" => %Plug.Upload{content_type: "application/octet-stream", filename: :filename, path: :dirname}}
    send_resp(conn, 200, "")
    
  end
  
  get _ do
    send_resp(conn, 404, "not found")
  end
end
