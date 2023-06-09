defmodule Repro.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ReproWeb.Telemetry,
      # Start the Ecto repository
      Repro.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Repro.PubSub},
      # Start Presence
      ReproWeb.Presence,
      # Start Finch
      {Finch, name: Repro.Finch},
      # Start the Endpoint (http/https)
      ReproWeb.Endpoint
      # Start a worker by calling: Repro.Worker.start_link(arg)
      # {Repro.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Repro.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ReproWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
