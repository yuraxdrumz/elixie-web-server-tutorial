defmodule SimpleServer.Repo do
  def findPermissions do
    :mongo |> Mongo.find("dynamiccaps", %{}) 
  end
end