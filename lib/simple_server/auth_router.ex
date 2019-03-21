defmodule SimpleServer.AuthRouter do
  use Plug.Router
  use Plug.ErrorHandler
  require Logger
  alias SimpleServer.AuthController

  # plug(Authentication)
  plug :match
  plug :dispatch

  get "/:user_id", do: AuthController.handle_user_id(conn)

  def handle_errors(conn, %{kind: kind, reason: reason, stack: stack}) do
    send_resp(conn, conn.status, Poison.encode!(%{kind: kind, reason: reason}))
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end