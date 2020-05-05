defmodule DomoticWeb.Live.Dashboard do
  use Phoenix.LiveView

  alias Domotic.Temperature

  @impl true
  def mount(_params, _session, socket) do
    {status, temperature, threshold} = Temperature.get()

    if connected?(socket), do: Temperature.subscribe()

    {:ok, assign(socket, status: status, temperature: temperature, threshold: threshold)}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <button class="button button--<%= if @status == :ok, do: 'ok', else: 'warning' %>">
      Temperature <span class="badge badge-light"><%= @temperature %>°C</span>
    </button>

    <span class="ml-6 text-sm">Target: <%= @threshold %>°C</span>
    """
  end

  @impl true
  def handle_info({status, temperature, threshold}, socket) do
    {:noreply, assign(socket, status: status, temperature: temperature, threshold: threshold)}
  end
end
