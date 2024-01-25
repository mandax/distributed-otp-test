defmodule Dotp do
  use Task

  @moduledoc """
  Documentation for `Dotp`.
  """
  @spec receive_message(String.t()) :: String.t()
  def receive_message(message) do
    IO.puts("Received message: #{message}")
    message
  end

  @spec send_message(pid(), String.t()) :: pid()
  def send_message(recipient, message) do
    spawn_task(__MODULE__, :receive_message, recipient, [message])
  end

  @spec spawn_task(module(), atom(), pid(), list(String.t())) :: pid()
  def spawn_task(module, fun, recipient, args) do
    recipient
    |> remote_supervisor()
    |> Task.Supervisor.async(module, fun, args)
    |> Task.await()
  end

  @spec remote_supervisor(pid()) :: tuple()
  def remote_supervisor(recipient) do
    {Dotp.TaskSupervisor, recipient}
  end
end
