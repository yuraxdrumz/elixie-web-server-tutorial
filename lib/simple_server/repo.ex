defmodule SimpleServer.Repo do
  require SimpleServer.DB
  def findPermissions do
    SimpleServer.DB.find("dynamiccaps", %{})
  end
end