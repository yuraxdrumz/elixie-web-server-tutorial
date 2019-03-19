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

    {:ok, body, conn} = read_body(conn)
        
    IO.inspect(body)
    
    send_resp(conn, 201, "created: #{get_in(body, ["message"])}")
    
  end
  
  get _ do
    send_resp(conn, 404, "not found")
  end
end
