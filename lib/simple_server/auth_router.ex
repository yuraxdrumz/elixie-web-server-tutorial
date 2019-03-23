defmodule SimpleServer.AuthRouter do
  use Plug.Router
  use Plug.ErrorHandler
  import SimpleServer.AuthController

  # alias SimpleServer.Authentication
  # plug(Authentication)
  
  plug :match
  plug :dispatch

  post "/", do: add_weather(conn)

  put "/:id", do: update_weather(conn)

  def handle_errors(conn, %{kind: kind, reason: reason, stack: _stack} = err) do
    IO.inspect err
    send_resp(conn, conn.status, reason)
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end