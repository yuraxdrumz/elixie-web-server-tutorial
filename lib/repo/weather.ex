defmodule SimpleServer.Weather do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Poison.Encoder, except: [:__meta__]}

  schema "weather" do
    field :city, :string
    field :temp_lo, :integer
    field :temp_hi, :integer
    field :prcp, :float, default: 0.0
    timestamps
  end
end