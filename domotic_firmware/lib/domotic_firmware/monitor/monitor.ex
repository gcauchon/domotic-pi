defmodule DomoticFirmware.Monitor do
  use GenServer

  require Logger

  alias Domotic.Temperature 

  @gpio_ok 21
  @gpio_warning 23

  def start_link(_default) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl true
  def init(_) do
    Logger.debug("Starting LEDs monitor…")

    {:ok, gpio_ok} = Circuits.GPIO.open(@gpio_ok, :output)
    {:ok, gpio_warning} = Circuits.GPIO.open(@gpio_warning, :output)
    pins = %{ok: gpio_ok, warning: gpio_warning}

    update(pins)

    {:ok, pins}
  end

  @impl true
  def handle_info(:update, pins) do
    update(pins) 

    {:noreply, pins}
  end

  defp update(%{ok: gpio_ok, warning: gpio_warning}) do
    Logger.debug("Updating LEDs…")

    Temperature.get()
    |> IO.inspect(label: "Temperature")
    |> case do
      {:ok, _temperature, _threshold} ->
        Circuits.GPIO.write(gpio_ok, 1)
        Circuits.GPIO.write(gpio_warning, 0)

      _ ->
        Circuits.GPIO.write(gpio_ok, 0)
        Circuits.GPIO.write(gpio_warning, 1)
    end
    
    Process.send_after(self(), :update, 5000)
  end
end
