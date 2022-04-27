defmodule DomoticWeb.Session do
  @spec get_options() :: keyword()
  def get_options do
    [
      store: :cookie,
      key: "domotic-pi",
      signing_salt: Application.get_env(:domotic, DomoticWeb.Endpoint)[:signing_salt]
    ]
  end
end
