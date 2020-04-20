defmodule DomoticWeb.Live.Dashboard do
  use Phoenix.LiveView

  alias Domotic.Temperature

  @impl true
  def mount(_params, _session, socket) do
    {status, temperature, threshold} = Temperature.get()

    Temperature.subscribe()

    {:ok, assign(socket, status: status, temperature: temperature, threshold: threshold)}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <button type="button" class="btn btn-<%= if @status == :ok, do: 'success', else: 'danger' %>">
      Temperature <span class="badge badge-light"><%= @temperature %>°C</span>
    </button>

    <span class="dashboard__tooltip">Target: <%= @threshold %>°C</span>
    """
  end

  @impl true
  def handle_info({status, temperature, threshold}, socket) do
    {:noreply, assign(socket, status: status, temperature: temperature, threshold: threshold)}
  end
end
