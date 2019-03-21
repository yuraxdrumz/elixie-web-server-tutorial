defmodule SimpleServer.RegController do
  alias Plug.Conn

  def handle_other(conn) do
    conn 
    |> Conn.send_resp(200, "other")
  end

  def handle_upload(conn) do
    stringified = Poison.encode!(conn.body_params)
    conn
    |> Conn.put_resp_content_type("application/json")
    |> Conn.send_resp(200, stringified)
  end
end