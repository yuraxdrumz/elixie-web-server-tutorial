defmodule SimpleServer.Repo do
  def findPermissions do
    :mongo 
      |> Mongo.find("users-permissions_permission", %{}) 
  end
end