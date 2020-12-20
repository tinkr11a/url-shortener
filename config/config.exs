use Mix.Config

config :url_shortener, UrlShortener.Repo,
  database: {:system, "DATABASE", "url_shortener_repo"},
  username: {:system, "DBUSERNAME", "postgres"},
  password: {:system, "DBPASSWORD", "mysecretpassword"},
  hostname: {:system, "DBHOSTNAME", "localhost"}

config :url_shortener, ecto_repos: [UrlShortener.Repo]

config :url_shortener, :http_config,
  port: {:system, "HTTP_PORT", 4001, {String, :to_integer}},
  host: {:system, "HTTP_HOST", "localhost"}
