defmodule SimpleServer.AuthController do
  require Logger
  import SimpleServer.Repo
  import Plug.Conn

  def handle_user_id(conn) do
    find_permissions() 
    |> Enum.to_list()  
    |> Poison.encode!
    |> (&send_resp(conn, 200, &1)).()
  end
end