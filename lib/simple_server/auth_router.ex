defmodule SimpleServer.AuthRouter do
  use Plug.Router
  use Plug.ErrorHandler
  import SimpleServer.AuthController

  # alias SimpleServer.Authentication
  # plug(Authentication)
  
  plug :match
  plug :dispatch

  post "/", do: add_weather(conn)

  get "/:id", do: get_weather(conn)

  put "/:id", do: update_weather(conn)

  get "/prcp/:min", do: get_prcp(conn)

  delete "/:id", do: delete_weather(conn)

  def handle_errors(conn, %{kind: kind, reason: reason, stack: _stack} = err) do
    try do
      IO.inspect err.reason.changeset.errors
      send_resp(conn, conn.status, Poison.encode!(err.reason.changeset.errors))
    rescue
      e in ArgumentError -> IO.inspect e.message
    after
      send_resp(conn, conn.status, "Something went wrong")
    end
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end