defmodule SimpleServer.Validator do

  def init(opts) do
    opts
  end

  defp checkParams(qs, bp, pp, path, opts) do
    
    IO.inspect qs
    IO.inspect bp
    IO.inspect pp
    IO.inspect elem(path, 0)
    IO.inspect opts
  end

  def call(%{query_params: qs, body_params: bp, path_params: pp, private: %{plug_route: path}} = conn, opts) do
    # IO.inspect conn
    # IO.inspect path
    opts
    |> Enum.map(&checkParams(qs, bp, pp, path, &1))
    conn
  end
end
