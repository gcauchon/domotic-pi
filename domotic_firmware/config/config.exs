import Config

# Enable the Nerves integration with Mix
Application.start(:nerves_bootstrap)

config :domotic_firmware, target: Mix.target()

# Customize non-Elixir parts of the firmware.
# ⮑ https://hexdocs.pm/nerves/advanced-configuration.html
config :nerves, :firmware, rootfs_overlay: "rootfs_overlay"

# Set the SOURCE_DATE_EPOCH date for reproducible builds
# ⮑ https://reproducible-builds.org/docs/source-date-epoch
config :nerves, source_date_epoch: "1651068865"

# Override Buildroot Linux’s default configuration to enable OneWire
# ⮑ http://www.carstenblock.org/post/project-excelsius/
config :nerves, :firmware, fwup_conf: "config/rpi0/fwup.conf"

# Use Ringlogger as the logger backend and remove :console
config :logger, backends: [RingLogger]

if Mix.target() == :host or Mix.target() == :"" do
  import_config "host.exs"
else
  import_config "target.exs"
end
