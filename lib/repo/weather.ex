defmodule SimpleServer.Weather do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Poison.Encoder, except: [:__meta__]}

  schema "weather" do
    field :city, :string
    field :temp_lo, :integer
    field :temp_hi, :integer
    field :prcp, :float, default: 0.0
    timestamps
  end

  def new_changeset(weather, params \\ %{}) do
    weather
    |> cast(params, [:city, :temp_lo, :temp_hi, :prcp])
    |> validate_required([:city, :temp_lo, :temp_hi, :prcp])
    |> validate_inclusion(:temp_lo, -60..60)
    |> validate_inclusion(:temp_hi, -60..60)
    |> validate_number(:prcp, less_than_or_equal_to: 100)
  end

  def update_changeset(weather, params \\ %{}) do
    weather
    |> cast(params, [:id])
    |> validate_required([:id])
  end

end