use Mix.Config

config :phoenix, :json_library, Jason

config :domotic, DomoticWeb.Endpoint,
  live_view: [
    signing_salt: System.fetch_env!("LIVEVIEW_SIGNING_SALT")
  ],
  pubsub_server: Domotic.PubSub,
  render_errors: [view: DomoticWeb.ErrorView, accepts: ~w(html json), layout: false],
  secret_key_base: System.fetch_env!("SESSION_SECRET_KEY_BASE")

config :ex_aws,
  access_key_id: System.fetch_env!("AWS_ACCESS_KEY_ID"),
  secret_access_key: System.fetch_env!("AWS_SECRET_ACCESS_KEY")

config :domotic, Domotic.Temperature.Probe, Domotic.Temperature.ProbeMock

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Environment specific configuration
import_config "#{Mix.env()}.exs"
