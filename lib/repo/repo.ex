# defmodule SimpleServer.Repo do
#   import SimpleServer.DB
#   def find_permissions do
#     find("dynamiccaps", %{})
#   end
# end

defmodule SimpleServer.Repo do
  use Ecto.Repo, otp_app: :simple_server, adapter: Mongo.Ecto
end