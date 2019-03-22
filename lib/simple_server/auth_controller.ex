defmodule SimpleServer.AuthController do
  require Logger
  alias SimpleServer.Repo
  alias SimpleServer.Weather
  import Plug.Conn

  def add_weather(conn) do
    %Weather{city: "Netanya", temp_lo: 10, temp_hi: 30, prcp: 70.5}
    |> Ecto.Changeset.change(%{})
    |> Repo.insert!()
    |> Poison.encode!
    |> IO.inspect
    |> (&send_resp(conn, 200, &1)).()
  end
end