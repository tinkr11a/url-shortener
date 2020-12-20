defmodule UrlShortener do
  use Application
  require Logger

  def start(:normal, []) do
    bootstrap()
    UrlShortener.Supervisor.start_link()
  end

  def bootstrap do
    DeferredConfig.populate(:url_shortener)
    {:ok, _} = EctoBootMigration.migrate(:url_shortener)

    :ok
  end

  def http_config do
    Application.fetch_env!(:url_shortener, :http_config)
  end
end
