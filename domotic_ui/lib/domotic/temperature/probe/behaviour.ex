defmodule Domotic.Temperature.Probe.Behaviour do
  @callback read() :: {:ok, number()} | {:error, String.t}
end
