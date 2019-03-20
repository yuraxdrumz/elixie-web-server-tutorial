defmodule SimpleServer.AuthRouter do
  use Plug.Router
  require Logger
  alias SimpleServer.Authentication
  alias SimpleServer.Repo

  plug(Authentication)
  plug :match
  plug :dispatch

  get "/:user_id" do
    data = Repo.findPermissions |> Enum.to_list()  |> Poison.encode!
    Logger.info data
    send_resp(conn, 200, data)
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end