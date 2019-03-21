defmodule SimpleServer.AuthController do
  require Logger
  import SimpleServer.Repo
  import Plug.Conn

  def handle_user_id(conn) do
    data = findPermissions |> Enum.to_list()  |> Poison.encode!
    Logger.info data
    conn 
    |> send_resp(200, data)
  end
end