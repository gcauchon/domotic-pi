import Config

# Use shoehorn to start the main application. See the shoehorn
# docs for separating out critical OTP applications such as those
# involved with firmware updates.
config :shoehorn,
  init: [:nerves_runtime, :nerves_pack],
  app: Mix.Project.config()[:app]

# Nerves Runtime can enumerate hardware devices and send notifications via
# SystemRegistry. This slows down startup and not many programs make use of
# this feature.
config :nerves_runtime, :kernel, use_system_registry: false

# Authorize the device to receive firmware using your public key.
# See https://hexdocs.pm/nerves_ssh/readme.html for more information
# on configuring nerves_ssh.
keys =
  [
    Path.join([System.user_home!(), ".ssh", "id_rsa.pub"]),
    Path.join([System.user_home!(), ".ssh", "id_ecdsa.pub"]),
    Path.join([System.user_home!(), ".ssh", "id_ed25519.pub"])
  ]
  |> Enum.filter(&File.exists?/1)

if keys == [],
  do:
    Mix.raise("""
    No SSH public keys found in ~/.ssh. An ssh authorized key is needed to
    log into the Nerves device and update firmware on it using ssh.
    See your project's config.exs for this error message.
    """)

config :nerves_ssh,
  authorized_keys: Enum.map(keys, &File.read!/1)

# Configure the network using vintage_net
# See https://github.com/nerves-networking/vintage_net for more information
config :vintage_net,
  regulatory_domain: "CA",
  config: [
    {"usb0", %{type: VintageNetDirect}},
    {"eth0",
     %{
       type: VintageNetEthernet,
       ipv4: %{method: :dhcp}
     }},
    {"wlan0",
     %{
       type: VintageNetWiFi,
       vintage_net_wifi: %{
         networks: [
           %{
             key_mgmt: :wpa_psk,
             ssid: System.fetch_env!("WIFI_SSID"),
             psk: System.fetch_env!("WIFI_PASSWORD")
           }
         ]
       }
     }}
  ]

config :mdns_lite,
  # The `host` key specifies what hostnames mdns_lite advertises.  `:hostname`
  # advertises the device's hostname.local. For the official Nerves systems, this
  # is "nerves-<4 digit serial#>.local".  mdns_lite also advertises
  # "nerves.local" for convenience. If more than one Nerves device is on the
  # network, delete "nerves" from the list.

  host: [:hostname, "nerves"],
  ttl: 120,

  # Advertise the following services over mDNS.
  services: [
    %{
      name: "SSH Remote Login Protocol",
      protocol: "ssh",
      transport: "tcp",
      port: 22
    },
    %{
      name: "Secure File Transfer Protocol over SSH",
      protocol: "sftp-ssh",
      transport: "tcp",
      port: 22
    },
    %{
      name: "Erlang Port Mapper Daemon",
      protocol: "epmd",
      transport: "tcp",
      port: 4369
    }
  ]

config :phoenix, :json_library, Jason

config :domotic, DomoticWeb.Endpoint,
  server: true,
  http: [port: 80],
  url: [host: "nerves.local"],
  pubsub_server: Domotic.PubSub,
  render_errors: [view: DomoticWeb.ErrorView, accepts: ~w(html json), layout: false],
  cache_static_manifest: "priv/static/cache_manifest.json",
  code_reloader: false,
  secret_key_base: System.fetch_env!("SECRET_KEY_BASE"),
  signing_salt: System.fetch_env!("SIGNING_SALT"),
  live_view: [
    signing_salt: System.fetch_env!("SIGNING_SALT")
  ]

# config :domotic, Domotic.Temperature.Probe, Domotic.Temperature.ProbeMock
config :domotic, Domotic.Temperature.Probe, DomoticFirmware.Temperature.Probe.DS18B20

# Import target specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
# Uncomment to use target specific configurations

# import_config "#{Mix.target()}.exs"
