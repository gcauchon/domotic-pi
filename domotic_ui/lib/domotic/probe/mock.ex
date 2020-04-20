defmodule Domotic.Probe.Mock do
  @behaviour Domotic.Probe.Behaviour

  @impl true
  def read, do: {:ok, Enum.random(-10..-20)} 
end
