# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :tiles, TilesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "UfndAT7/Y5FFH8L3uGoP8PeKUlNWIbmz8w/SlDXDbzWd4+RTt4Izwx6ctrLaJNVt",
  render_errors: [view: TilesWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Tiles.PubSub,
  live_view: [signing_salt: "zB4TB9ie"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
