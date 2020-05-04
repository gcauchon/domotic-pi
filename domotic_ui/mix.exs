defmodule Domotic.MixProject do
  use Mix.Project

  def project do
    [
      app: :domotic,
      version: "0.1.0",
      elixir: "~> 1.10",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # OTP application
  def application do
    [
      mod: {Domotic.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp aliases do
    [
      setup: ["deps.get", "cmd npm install --prefix assets"]
    ]
  end

  defp deps do
    [
      {:phoenix, "~> 1.5"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_view, "~> 0.12"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_dashboard, "~> 0.2"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.1"}
    ]
  end
end
