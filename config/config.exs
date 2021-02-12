# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :what_the_hex,
  ecto_repos: [WhatTheHex.Repo]

# Configures the endpoint
config :what_the_hex, WhatTheHexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JIE5thq3v9i5/bbASETY6gWXskzcjlWPbfhYIZjESFWaq9QNf+sI/oIV4nhdSio5",
  render_errors: [view: WhatTheHexWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: WhatTheHex.PubSub,
  live_view: [signing_salt: "jBF49YfK"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
