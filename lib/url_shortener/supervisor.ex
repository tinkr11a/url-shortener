defmodule UrlShortener.Supervisor do
  @moduledoc false

  use Supervisor
  require Logger

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: UrlShortener.Router,
        options: [port: UrlShortener.http_config()[:port]]
      ),
      {UrlShortener.Repo, []}
    ]

    Logger.debug("Router started at #{UrlShortener.http_config()[:port]}")

    Supervisor.init(children, strategy: :one_for_one)
  end
end
