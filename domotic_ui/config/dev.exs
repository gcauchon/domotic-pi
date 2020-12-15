use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
config :domotic, DomoticWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/domotic_web/(live|views)/.*(ex)$",
      ~r"lib/domotic_web/templates/.*(eex)$"
    ]
  ],
  watchers: [
    npm: [
      "run",
      "watch",
      cd: Path.expand("../assets", __DIR__)
    ]
  ]

# Set a higher stacktrace during development.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"
