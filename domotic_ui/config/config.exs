use Mix.Config

config :phoenix, :json_library, Jason

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args: ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :domotic, DomoticWeb.Endpoint,
  http: [port: System.get_env("PORT") |> String.to_integer()],
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
