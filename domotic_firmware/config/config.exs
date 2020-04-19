import Config

# Deploying to a device, use the "prod" configuration
import_config "../../domotic_ui/config/config.exs"
import_config "../../domotic_ui/config/prod.exs"

# Customize non-Elixir parts of the firmware.
# See https://hexdocs.pm/nerves/advanced-configuration.html
config :nerves, :firmware, rootfs_overlay: "rootfs_overlay"

# Set the SOURCE_DATE_EPOCH date for reproducible builds
config :nerves, source_date_epoch: "1587180600"

config :domotic_firmware, target: Mix.target()

config :domotic_ui, DomoticUiWeb.Endpoint,
  code_reloader: false,
  http: [port: 80], 
  load_from_system_env: false,
  render_errors: [view: UiWeb.ErrorView, accepts: ~w(html json)],
  root: Path.dirname(__DIR__),
  server: true,
  url: [host: "nerves.local", port: 80]

# Use Ringlogger as the logger backend and remove :console
config :logger, backends: [RingLogger]

if Mix.target() != :host do
  import_config "target.exs"
end
