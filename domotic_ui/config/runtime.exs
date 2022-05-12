import Config

config :domotic, DomoticWeb.Endpoint,
  http: [port: System.fetch_env!("PORT") |> String.to_integer()],
  secret_key_base: System.fetch_env!("SECRET_KEY_BASE"),
  signing_salt: System.fetch_env!("SIGNING_SALT"),
  live_view: [
    signing_salt: System.fetch_env!("SIGNING_SALT")
  ]
