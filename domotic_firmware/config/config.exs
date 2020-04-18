import Config

# When we deploy to a device, we use the "prod" configuration:
import_config "../../domotic_ui/config/config.exs"
import_config "../../domotic_ui/config/prod.exs"

config :domotic_firmware, target: Mix.target()

config :domotic_ui, DomoticUiWeb.Endpoint,
  code_reloader: false, # Nerves root filesystem is read-only, so disable the code reloader
  http: [port: 80], 
  load_from_system_env: false, # Use compile-time Mix config instead of runtime environment variables 
  server: true, # Start the server since we're running in a release instead of through `mix`
  url: [host: "nerves.local", port: 80]

# Customize non-Elixir parts of the firmware. See
# https://hexdocs.pm/nerves/advanced-configuration.html for details.
config :nerves, :firmware, rootfs_overlay: "rootfs_overlay"

# Set the SOURCE_DATE_EPOCH date for reproducible builds.
# See https://reproducible-builds.org/docs/source-date-epoch/ for more information
config :nerves, source_date_epoch: "1587180600"

# Use Ringlogger as the logger backend and remove :console.
# See https://hexdocs.pm/ring_logger/readme.html for more information on
# configuring ring_logger.
config :logger, backends: [RingLogger]

if Mix.target() != :host do
  import_config "target.exs"
end
