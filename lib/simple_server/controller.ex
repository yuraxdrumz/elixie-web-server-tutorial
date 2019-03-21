defmodule SimpleServer.RegController do
  import Plug.Conn

  def handle_other(conn) do
    conn 
    |> put_resp_content_type("application/json")
    |> send_resp(200, "other")
  end

  def handle_upload(conn) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(conn.body_params))
  end
end