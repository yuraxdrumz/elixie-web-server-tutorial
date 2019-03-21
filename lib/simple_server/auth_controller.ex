defmodule SimpleServer.AuthController do
  import Logger
  import SimpleServer.Repo
  import Plug.Conn

  def handle_user_id(conn) do
    data = findPermissions |> Enum.to_list()  |> Poison.encode!
    info data
    conn 
    |> send_resp(200, data)
  end
end