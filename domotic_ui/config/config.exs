use Mix.Config

# Configures the endpoint
config :domotic, DomoticWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "8e5Pn7Ttbdip+GuV1Y8xVxCbFDBObBrabX33PwStgTSnzvciNqYXrN3oZCGxIwFP",
  render_errors: [view: DomoticWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Domotic.PubSub,
  live_view: [signing_salt: "LezYvAG6"]

config :domotic, Domotic.Temperature.Probe, Domotic.Temperature.ProbeMock

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
