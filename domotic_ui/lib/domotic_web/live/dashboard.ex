defmodule DomoticWeb.Live.Dashboard do
  use Phoenix.LiveView

  alias Domotic.Temperature

  def mount(_params, _session, socket) do
    {status, temperature, threshold} = Temperature.get()
    schedule_update()

    {:ok, assign(socket, status: status, temperature: temperature, threshold: threshold)}
  end

  def render(assigns) do
    ~L"""
    <button type="button" class="btn btn-<%= if @status == :ok, do: 'success', else: 'danger' %>">
      Temperature <span class="badge badge-light"><%= @temperature %>°C</span>
    </button>

    <span class="dashboard__tooltip">Target: <%= @threshold %>°C</span>
    """
  end

  def handle_info(:update, socket) do
    {status, temperature, threshold} = Temperature.get()
    schedule_update()

    {:noreply, assign(socket, status: status, temperature: temperature, threshold: threshold)}
  end

  defp schedule_update, do: Process.send_after(self(), :update, 5000)
end
