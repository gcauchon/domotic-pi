use Mix.Config

# We don't run a server during test.
config :domotic, DomoticWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn
