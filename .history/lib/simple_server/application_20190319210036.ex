defmodule SimpleServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias Plug.Adapters.Cowboy
  require Logger

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: SimpleServer.Worker.start_link(arg)
      # {SimpleServer.Worker, arg}
      Cowboy.child_spec(scheme: :http, plug: SimpleServer.Router, options: [port: Application.fetch_env!(:simple_server, :port)])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SimpleServer.Supervisor]
    Logger.info("Starting application...")
    case Mongo.start_link(url: "mongodb://localhost:27017/ServerFree", name: :mongo) do
      {:ok, _} -> Logger.info "Connected to mongo"
      {:error, err} -> Logger.error err
      _ -> Logger.info "Something went wrong"
    end

    Supervisor.start_link(children, opts)
  end
end
