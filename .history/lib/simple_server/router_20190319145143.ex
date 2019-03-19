defmodule SimpleServer.Router do
  use Plug.Router
  use Plug.Debugger
  require Logger

plug(Plug.Logger, log: :debug)

plug(:match)

plug(:dispatch)

# TODO: add routes!

get "/hello" do
  send_resp(conn, 200, "world")
end


end