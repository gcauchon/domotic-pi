use Mix.Config

config :phoenix, :json_library, Jason

config :domotic, DomoticWeb.Endpoint,
  live_view: [
    signing_salt: System.get_env("LIVEVIEW_SIGNING_SALT", "kfMiQRupVUymfq18fnn+CB+Sroa4ST75")
  ],
  pubsub_server: Domotic.PubSub,
  render_errors: [view: DomoticWeb.ErrorView, accepts: ~w(html json), layout: false],
  secret_key_base: System.get_env("SESSION_SECRET_KEY_BASE", "L7GVIymGk7nNsRTPRC9Z3r7O6BgPdsaE")

config :domotic, Domotic.Temperature.Probe, Domotic.Temperature.ProbeMock

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Environment specific configuration
import_config "#{Mix.env()}.exs"
