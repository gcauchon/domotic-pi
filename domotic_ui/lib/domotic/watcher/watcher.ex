defmodule Domotic.Watcher do
  use GenServer

  def start_link(_default) do
    GenServer.start_link(__MODULE__, %{timestamp: :never, temperature: nil}, name: Domotic.Watcher)
  end

  def get_temperature() do
    GenServer.call(Domotic.Watcher, :read)
  end

  @impl true
  def init(state) do
    schedule_work()

    {:ok, state}
  end

  @impl true
  def handle_info(:check, _temperature) do
    {:ok, temperature} = get_probe().read()
    state = %{temperature: temperature, timestamp: DateTime.utc_now()}

    Phoenix.PubSub.broadcast(Domotic.PubSub, "watcher", state)

    schedule_work()

    {:noreply, state}
  end

  @impl true
  def handle_call(:read, _from, state) do
    {:reply, state, state}
  end

  defp schedule_work() do
    Process.send_after(self(), :check, 5 * 1000) # every 5 seconds
  end

  defp get_probe, do: Application.get_env(:domotic, Domotic.Probe)
end
