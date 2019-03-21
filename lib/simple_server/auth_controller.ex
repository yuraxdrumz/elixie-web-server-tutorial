defmodule SimpleServer.AuthController do
  require Logger
  alias SimpleServer.Repo
  alias Plug.Conn

  def handle_user_id(conn) do
    data = Repo.findPermissions |> Enum.to_list()  |> Poison.encode!
    Logger.info data
    conn 
    |> Conn.send_resp(200, data)
  end
end