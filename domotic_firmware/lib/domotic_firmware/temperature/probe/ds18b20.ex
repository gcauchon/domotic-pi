defmodule DomoticFirmware.Temperature.Probe.DS18B20 do
  @behaviour Domotic.Temperature.Probe.Behaviour

  @base_dir "/sys/bus/w1/devices"

  def read do
    with sensor_id <- get_sensor_id(),
         data <- read_sensor_data(sensor_id),
         {temp, _} when is_integer(temp) <- parse_temperature(data) do
      {:ok, temp / 1000}
    else
      _ ->
        {:error, "Invalid sensor configuration"}
    end
  end

  defp get_sensor_id() do
    File.ls!(@base_dir)
    |> Enum.filter(&String.starts_with?(&1, "28-"))
    |> List.first()
  end

  defp read_sensor_data(sensor_id), do: File.read!("#{@base_dir}/#{sensor_id}/w1_slave")

  defp parse_temperature(data) do
    Regex.run(~r/t=(-?[[:digit:]]+)/, data, capture: :all_but_first)
    |> List.first()
    |> Integer.parse()
  end
end
