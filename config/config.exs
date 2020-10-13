# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :desafio2,
  ecto_repos: [Desafio2.Repo]

# Configures the endpoint
config :desafio2, Desafio2Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EX4bXPEruk8VUaGERfXwtuISboU83B9ntC/hTYaH5Lms3yt47pbROIaw/zmejqci",
  render_errors: [view: Desafio2Web.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Desafio2.PubSub,
  live_view: [signing_salt: "AVgple48"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :logger,
  backends: [:console, Sentry.LoggerBackend]
