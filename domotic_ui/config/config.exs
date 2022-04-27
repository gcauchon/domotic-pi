import Config

config :phoenix, :json_library, Jason

config :esbuild,
  version: "0.14.38",
  default: [
    args: ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :tailwind,
  version: "3.0.24",
  default: [
    args: ~w(
    --config=tailwind.config.js
    --input=css/app.css
    --output=../priv/static/assets/app.css
  ),
    cd: Path.expand("../assets", __DIR__)
  ]

config :domotic, DomoticWeb.Endpoint,
  pubsub_server: Domotic.PubSub,
  render_errors: [view: DomoticWeb.ErrorView, accepts: ~w(html json), layout: false]

config :domotic, Domotic.Temperature.Probe, Domotic.Temperature.ProbeMock

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Environment specific configuration
import_config "#{Mix.env()}.exs"
