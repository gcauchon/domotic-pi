defmodule DomoticFirmware.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do 
    children =
      [
        # Children for all targets
        # Starts a worker by calling: DomoticFirmware.Worker.start_link(arg)
        # {DomoticFirmware.Worker, arg},
      ] ++ children(target())

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DomoticFirmware.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # List all child processes to be supervised
  def children(:host) do
    [
      # Children that only run on the host
      # Starts a worker by calling: DomoticFirmware.Worker.start_link(arg)
      # {DomoticFirmware.Worker, arg},
    ]
  end

  def children(_target) do
    [
      # Children for all targets except host
      # Starts a worker by calling: DomoticFirmware.Worker.start_link(arg)
      # {DomoticFirmware.Worker, arg},
      DomoticFirmware.Monitor
    ]
  end

  def target(), do: Application.get_env(:domotic_firmware, :target)
end
