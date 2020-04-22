defmodule Domotic.Temperature do
  use GenServer

  @topic inspect(__MODULE__)
  @threshold -15.0

  #
  # Client
  #
  def start_link(_args) do
    GenServer.start_link(__MODULE__, {:ok, @threshold, @threshold}, name: :watcher)
  end

  @spec get() :: {:ok, number(), number()} | {:warning, number(), number()} | {:error, any()}
  def get() do
    GenServer.call(:watcher, :get)
  end

  #
  # Server (callbacks)
  #
  @impl true
  def init(state) do
    schedule_update()

    {:ok, state}
  end

  @impl true
  def handle_info(:update, _temperature) do
    state =
      case get_probe().read() do
        {:ok, temperature} when temperature <= @threshold ->
          {:ok, temperature, @threshold}

        {:ok, temperature} ->
          {:warning, temperature, @threshold}

        {:error, error} ->
          {:error, error}
      end

    schedule_update()
    notify(state)

    {:noreply, state}
  end

  @impl true
  def handle_call(:get, _from, temperature) do
    {:reply, temperature, temperature}
  end

  defp schedule_update() do
    Process.send_after(self(), :update, 5000)
  end

  def subscribe do
    Phoenix.PubSub.subscribe(Domotic.PubSub, @topic)
  end

  def notify(temperature) do
    Phoenix.PubSub.broadcast(Domotic.PubSub, @topic, temperature)
  end

  defp get_probe(), do: Application.get_env(:domotic, Domotic.Temperature.Probe)
end
