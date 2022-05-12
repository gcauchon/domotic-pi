defmodule DomoticWeb.Live.Dashboard do
  use Phoenix.LiveView

  alias Domotic.Temperature

  alias Contex.{LinePlot, Dataset, Plot}

  @impl true
  def mount(_params, _session, socket) do
    {status, temperature, threshold} = Temperature.get()

    if connected?(socket), do: Temperature.subscribe()

    data = for _index <- 1..10, into: [] do
      Process.sleep(500)

      [DateTime.utc_now(), :rand.uniform(6) - 18]
    end
    dataset = Dataset.new(data, ["Time", "Temperature"])

    options = [
      mapping: %{x_col: "Time", y_cols: ["Temperature"]},
      smoothed: true
    ]

    chart = Plot.new(dataset, LinePlot, 600, 400, options)
    |> Plot.to_svg

    {:ok, assign(socket, status: status, temperature: temperature, chart: chart, threshold: threshold)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <header>
      <button class={if @status == :ok, do: "button button--ok", else: "button button--warning"}>
        Temperature <span class="badge badge-light"><%= @temperature %>°C</span>
      </button>

      <span class="ml-6 text-sm">Target: <%= @threshold %>°C</span>
    </header>

    <div class="pt-8 w-96">
      <%= @chart %>
    </div>
    """
  end

  @impl true
  def handle_info({status, temperature, threshold}, socket) do
    {:noreply, assign(socket, status: status, temperature: temperature, threshold: threshold)}
  end
end
