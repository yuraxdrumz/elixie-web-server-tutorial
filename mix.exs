defmodule SimpleServer.MixProject do
  use Mix.Project

  def project do
    [
      app: :simple_server,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :cowboy, :plug, :poison, :mongodb, :remix, :mongodb_ecto, :ecto],
      mod: {SimpleServer.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, "~> 1.0.0"},
      {:plug, "~> 1.5"},
      {:poison, "~> 3.1"},
      {:plug_cowboy, "~> 1.0"},
      {:mongodb, ">= 0.0.0"},
      {:joken, "~> 2.0"},
      {:remix, "~> 0.0.1", only: :dev},
      {:loggix, "~> 0.0.9"},
      {:mongodb_ecto, "~> 0.1"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
