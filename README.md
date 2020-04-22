# DomoticPi

My first IoT playground based on Raspberry Pi and the amazing [Nerves](
https://www.nerves-project.org/) platform!

<p align="center">
  <img width="600" alt="Screen Shot 2020-04-21 at 21 11 24" src="https://user-images.githubusercontent.com/801045/79929796-d40c2700-8414-11ea-8ac8-adad8fb2e768.png">
</p>

A <em>RaspberryPi Zero Wireless</em> device using a [DS18D20 temperature sensor](
https://cdn-shop.adafruit.com/datasheets/DS18B20.pdf), LEDs and a Phoenix live view
to monitor the freezer temperature never to waste precious wild meat.

# Nerves

### Targets

Nerves applications produce images for hardware targets based on the `MIX_TARGET`
environment variable. If `MIX_TARGET` is unset, `mix` builds an image that runs
on the host (e.g., your laptop). This is useful for executing logic tests,
running utilities, and debugging. Other targets are represented by a short name
like `rpi3` that maps to a Nerves system image for that platform. All of this
logic is in the generated `mix.exs` and may be customized. For more information
about targets see:

https://hexdocs.pm/nerves/targets.html#content

### Getting Started

To start your Nerves app:
  * Install dependencies with `mix deps.get`
  * Generate environment variables from `.env` with `mix phx.get.secret 32`
  * Export envvironment variables with the tool of your choice, mine is [`direnv`](https://direnv.net/)
  * Create firmware with `mix firmware`
  * Burn to an SD card with `mix firmware.burn`

### Learn more

  * Official docs: https://hexdocs.pm/nerves/getting-started.html
  * Official website: https://nerves-project.org/
  * Forum: https://elixirforum.com/c/nerves-forum
  * Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
  * Source: https://github.com/nerves-project/nerves
