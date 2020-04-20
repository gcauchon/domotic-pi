defmodule DomoticFirmware.Monitor do
  use GenServer

  alias Domotic.Temperature

  @gpio_ok 21
  @gpio_warning 23

  def start_link(_args) do
    GenServer.start_link(__MODULE__, %{}, name: :monitor)
  end

  @impl true
  def init(_state) do
    {:ok, gpio_ok} = Circuits.GPIO.open(@gpio_ok, :output)
    {:ok, gpio_warning} = Circuits.GPIO.open(@gpio_warning, :output)
    
    pins = %{ok: gpio_ok, warning: gpio_warning}
    update(pins, Temperature.get())

    Temperature.subscribe()

    {:ok, pins}
  end

  @impl true
  def handle_info(temperature, pins) when is_tuple(temperature) do
    update(pins, temperature) 

    {:noreply, pins}
  end

  defp update(%{ok: gpio_ok, warning: gpio_warning}, {:ok, _temperature, _threshold}) do
    Circuits.GPIO.write(gpio_ok, 1)
    Circuits.GPIO.write(gpio_warning, 0)
  end

  defp update(%{ok: gpio_ok, warning: gpio_warning}, {_status, _temperature, _threshold}) do
    Circuits.GPIO.write(gpio_ok, 0)
    Circuits.GPIO.write(gpio_warning, 1)
  end
end
