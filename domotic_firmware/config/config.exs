import Config

import_config "../../domotic_ui/config/config.exs"

# Customize non-Elixir parts of the firmware.
# ⮑ https://hexdocs.pm/nerves/advanced-configuration.html
config :nerves, :firmware, rootfs_overlay: "rootfs_overlay"

# Set the SOURCE_DATE_EPOCH date for reproducible builds
# ⮑ https://reproducible-builds.org/docs/source-date-epoch
config :nerves, source_date_epoch: "1587180600"

# Override Buildroot Linux’s default configuration to enable 1-Wire
# ⮑ http://www.carstenblock.org/post/project-excelsius/
config :nerves, :firmware, fwup_conf: "config/rpi0/fwup.conf"

config :domotic_firmware, target: Mix.target()

config :domotic, Domotic.Temperature.Probe, DomoticFirmware.Temperature.Probe.DS18B20

config :domotic, DomoticWeb.Endpoint,
  cache_static_manifest: "priv/static/cache_manifest.json",
  code_reloader: false,
  http: [
    port: 80,
    transport_options: [socket_opts: [:inet6]]
  ],
  load_from_system_env: false,
  server: true,
  url: [
    host: "nerves-dev.local",
    port: 80
  ]

# Use Ringlogger as the logger backend and remove :console
config :logger, backends: [RingLogger]

if Mix.target() != :host do
  import_config "target.exs"
end
