defmodule SimpleServer.DB do
  defimpl Poison.Encoder, for: BSON.ObjectId do
    def encode(id, options) do
      BSON.ObjectId.encode!(id) |> Poison.Encoder.encode(options)
    end
  end
  def connect() do 
    Mongo.start_link(url: "mongodb://localhost:27017/my", name: :mongo)
  end
end