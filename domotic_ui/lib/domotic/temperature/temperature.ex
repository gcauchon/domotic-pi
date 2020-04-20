defmodule Domotic.Temperature do

  @topic inspect(__MODULE__)
  @threshold -15.0

  @spec get() :: {:ok, number(), number()} | {:warning, number(), number()} | {:error, any()}
  def get() do
    case get_probe().read() do
      {:ok, temperature} when temperature <= @threshold ->
        {:ok, temperature, @threshold}

      {:ok, temperature} ->
        {:warning, temperature, @threshold}

      {:error, error} ->
        {:error, error}
    end
  end

  def subscribe do
    Phoenix.PubSub.subscribe(Domotic.PubSub, @topic)
  end

  def notify(temperature) do
    Phoenix.PubSub.broadcast(Demo.PubSub, @topic, temperature)
  end

  defp get_probe(), do: Application.get_env(:domotic, Domotic.Temperature.Probe)
end
