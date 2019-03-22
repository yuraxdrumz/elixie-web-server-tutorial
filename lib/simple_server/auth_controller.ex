defmodule SimpleServer.AuthController do
  require Logger
  alias SimpleServer.Repo
  alias SimpleServer.Weather
  import Plug.Conn

  def add_weather(conn) do
    %Weather{}
    |> Weather.new_changeset(%{city: "Netanya", temp_lo: 10, temp_hi: 60, prcp: 70})
    |> Repo.insert!
    |> Poison.encode!
    |> (&send_resp(conn, 200, &1)).()
  end

  def update_weather(conn) do
    Weather
    |> Repo.get!(conn.path_params["id"])
    |> Weather.update_changeset(%{city: conn.body_params["city"]})    
    |> Repo.update!
    |> Poison.encode!
    |> (&send_resp(conn, 200, &1)).()
  end
end