use Mix.Config

# We don't run a server during test.
config :domotic_ui, DomoticUiWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn
