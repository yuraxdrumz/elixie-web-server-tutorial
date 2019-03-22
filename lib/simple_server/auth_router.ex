defmodule SimpleServer.AuthRouter do
  use Plug.Router
  use Plug.ErrorHandler
  import SimpleServer.AuthController

  # alias SimpleServer.Authentication
  # plug(Authentication)
  
  plug :match
  plug :dispatch

  get "/", do: add_weather(conn)

  def handle_errors(conn, %{kind: kind, reason: reason, stack: _stack}) do
    send_resp(conn, conn.status, Poison.encode!(%{kind: kind, reason: reason}))
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end