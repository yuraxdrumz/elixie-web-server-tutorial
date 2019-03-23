defmodule SimpleServer.AuthController do
  require Logger
  alias SimpleServer.Repo
  alias SimpleServer.Weather
  import Plug.Conn
  import Ecto.Query

  
  def get_weather(conn) do
    Weather
    |> Repo.get!(conn.path_params["id"])
    |> Poison.encode!
    |> (&send_resp(conn, 200, &1)).()
  end


  def get_prcp(conn) do
    query = from w in Weather, where: w.prcp > ^conn.path_params["min"], select: %{city: w.city, id: w.id}
    Repo.all(query)
    |> Poison.encode!
    |> (&send_resp(conn, 200, &1)).()
  end

  def delete_weather(conn) do
    %Weather{id: conn.path_params["id"]}
    |> Repo.delete!
    |> Poison.encode!
    |> (&send_resp(conn, 200, &1)).()
  end

  def add_weather(conn) do
    %Weather{}
    |> Weather.new_changeset(%{city: conn.body_params["city"], temp_lo: conn.body_params["temp_lo"], temp_hi: conn.body_params["temp_hi"], prcp: conn.body_params["prcp"]})
    |> Repo.insert!
    |> Poison.encode!
    |> (&send_resp(conn, 200, &1)).()
  end

  def update_weather(conn) do
    %Weather{id: conn.path_params["id"]}
    |> Weather.update_changeset(%{city: conn.body_params["city"], temp_lo: conn.body_params["temp_lo"], temp_hi: conn.body_params["temp_hi"], prcp: conn.body_params["prcp"]})   
    |> Repo.update!
    |> Poison.encode!
    |> (&send_resp(conn, 200, &1)).()
  end
end