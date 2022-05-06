defmodule Domotic.MixProject do
  use Mix.Project

  def project do
    [
      app: :domotic,
      version: "0.4.0",
      elixir: "~> 1.13",
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
      "assets.deploy": [
        "esbuild default --minify",
        "tailwind default --minify",
        "phx.digest"
      ]
    ]
  end

  defp deps do
    [
      # Plug
      {:plug_cowboy, "~> 2.5"},

      # Phoenix
      {:phoenix, "~> 1.6"},
      {:phoenix_html, "~> 3.1"},
      {:phoenix_live_view, "~> 0.17"},
      {:phoenix_live_reload, "~> 1.3", only: :dev},
      {:phoenix_live_dashboard, "~> 0.6"},
      {:jason, "~> 1.2"},

      # AWS
      {:hackney, "~> 1.18"},
      {:ex_aws, "~> 2.3"},

      # Gettext
      {:gettext, "~> 0.19"},

      # Telemetry
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},

      # Assets pipeline
      {:esbuild, "~> 0.4", runtime: Mix.env() == :dev && Mix.target() == :host},
      {:tailwind, "~> 0.1", runtime: Mix.env() == :dev && Mix.target() == :host}
    ]
  end
end
