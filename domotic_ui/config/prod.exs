use Mix.Config

# For production, don't forget to configure the url host
# to something meaningful, Phoenix uses this information
# when generating URLs.
config :domotic_ui, DomoticUiWeb.Endpoint,
  url: [host: "example.com", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json"

# Do not print debug messages in production
config :logger, level: :info

# Finally import the config/prod.secret.exs
import_config "prod.secret.exs"
