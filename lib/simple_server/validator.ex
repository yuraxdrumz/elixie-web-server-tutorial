defmodule SimpleServer.Validator do
  import Plug.Conn

  def init(opts) do
    opts
  end


  def call(conn, _opts) do
    conn
  end
end
