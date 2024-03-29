defmodule Domotic.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Phoenix.PubSub, name: Domotic.PubSub},
      Domotic.Telemetry,
      Domotic.Temperature,
      DomoticWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Domotic.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DomoticWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
