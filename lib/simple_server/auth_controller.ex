defmodule SimpleServer.AuthController do
  require Logger
  import SimpleServer.Repo
  import Plug.Conn

  def handle_user_id(conn) do
    findPermissions 
    |> Enum.to_list()  
    |> Poison.encode!
    |> (&send_resp(conn, 200, &1)).()
  end
end