defmodule DomoticUiWeb.Live.Dashboard do
  use Phoenix.LiveView

  @temperature_threshold -15.0
 
  def mount(_params, _session, socket) do
    Phoenix.PubSub.subscribe(DomoticUi.PubSub, "watcher")

    {:ok, assign(socket, :temperature, @temperature_threshold)}
  end

  def render(assigns) do
    ~L"""
    <button type="button" class="btn <%= temperature_level(@temperature) %>">
      Temperature <span class="badge badge-light"><%= @temperature %>°C</span>
    </button>

    <span class="dashboard__tooltip">Target: <%= temperature_threshold() %>°C</span>
    """
  end

  def handle_info(%{timestamp: _timestamp, temperature: temperature}, socket) do
    {:noreply, assign(socket, :temperature, temperature)}
  end

  defp temperature_threshold, do: @temperature_threshold

  defp temperature_level(temperature) do
    if temperature <= @temperature_threshold do
      "btn-success"
    else
      "btn-danger"
    end
  end
end
