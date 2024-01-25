defmodule Dotp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    IO.puts("Starting Application" <> inspect(Node.self()))
    IO.puts("Cookie" <> inspect(Node.get_cookie()))

    children = [
      {Task.Supervisor, name: Dotp.TaskSupervisor}
      # Starts a worker by calling: Dotp.Worker.start_link(arg)
      # {Dotp.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Dotp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
