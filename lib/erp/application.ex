defmodule Erp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ErpWeb.Telemetry,
      Erp.Repo,
      {DNSCluster, query: Application.get_env(:erp, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Erp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Erp.Finch},
      # Start a worker by calling: Erp.Worker.start_link(arg)
      # {Erp.Worker, arg},
      # Start to serve requests, typically the last entry
      ErpWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Erp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ErpWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
