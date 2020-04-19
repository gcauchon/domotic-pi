defmodule DomoticUiWeb.Live.Dashboard do
  use Phoenix.LiveView
 
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :temperature, 0)}
  end

  def render(assigns) do
    ~L"""
    Current temperature: <%= @temperature %> 
    """
  end
end
