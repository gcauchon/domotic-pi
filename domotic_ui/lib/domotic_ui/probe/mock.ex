defmodule DomoticUi.Probe.Mock do
  @behaviour DomoticUi.Probe.Behaviour

  @impl true
  def read, do: {:ok, Enum.random(-10..-20)} 
end
