defmodule SimpleServer.Repo do
  import SimpleServer.DB
  def find_permissions do
    find("dynamiccaps", %{})
  end
end