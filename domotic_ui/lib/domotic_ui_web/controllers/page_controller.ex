defmodule DomoticUiWeb.PageController do
  use DomoticUiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
