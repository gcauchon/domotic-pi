defmodule Domotic.Temperature.ProbeMock do
  @behaviour Domotic.Temperature.Probe.Behaviour

  @impl true
  def read, do: {:ok, Enum.random(-10..-20)} 
end
