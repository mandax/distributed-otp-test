defmodule Dotp.MixProject do
  use Mix.Project

  def project do
    [
      app: :dotp,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: [
        driver: [
          version: "0.0.1",
          applications: [dotp: :permanent],
          cookie: "secret"
        ],
        app: [
          version: "0.0.1",
          applications: [dotp: :permanent],
          coolie: "secret"
        ]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Dotp.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
