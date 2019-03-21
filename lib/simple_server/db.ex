defmodule SimpleServer.DB do
  defimpl Poison.Encoder, for: BSON.ObjectId do
    def encode(id, options) do
      BSON.ObjectId.encode!(id) |> Poison.Encoder.encode(options)
    end
  end
  def connect() do 
    Mongo.start_link(url: Application.get_env(:simple_server, :uri), name: Application.get_env(:simple_server, :name))
  end
  def find(coll_name, opts) do 
    :mongo |> Mongo.find(coll_name, opts) 
  end
end