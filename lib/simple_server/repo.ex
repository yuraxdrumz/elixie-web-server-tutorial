defmodule SimpleServer.Repo do
  import SimpleServer.DB
  def findPermissions do
    find("dynamiccaps", %{})
  end
end