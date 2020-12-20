defmodule UrlShortener.MixProject do
  use Mix.Project

  def project do
    [
      app: :url_shortener,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  defp aliases do
    [
      test: "test --no-start"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :plug_cowboy],
      mod: {UrlShortener, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.4"},
      {:poison, "~> 4.0"},
      {:deferred_config, "~> 0.1"},
      {:plug_validator, "~> 0.1"},
      {:base62, "~> 1.2"},
      {:ecto_sql, "~> 3.5"},
      {:postgrex, "~> 0.15"},
      {:assert_value, "~> 0.9", only: :test},
      {:mock, "~> 0.3"},
      {:ecto_boot_migration, "~> 0.2"}
    ]
  end
end
