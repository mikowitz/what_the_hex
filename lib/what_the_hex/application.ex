defmodule WhatTheHex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      WhatTheHexWeb.Telemetry,
      # WhatTheHex.Repo,
      {DNSCluster, query: Application.get_env(:what_the_hex, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: WhatTheHex.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: WhatTheHex.Finch},
      # Start a worker by calling: WhatTheHex.Worker.start_link(arg)
      # {WhatTheHex.Worker, arg},
      # Start to serve requests, typically the last entry
      WhatTheHexWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WhatTheHex.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WhatTheHexWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
