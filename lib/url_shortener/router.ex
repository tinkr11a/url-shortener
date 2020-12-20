defmodule UrlShortener.Router do
  @moduledoc false

  require Logger
  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
  plug(:dispatch)

  get "/alive" do
    send_resp(conn, 200, "1")
  end

  get "/short_url" do
    conn.query_params["url"]
    |> UrlShortener.Converter.to_short()
    |> case do
      {:ok, short_url} ->
        conn
        |> return_json(200, %{short_url: short_url})

      {:error, reason} ->
        conn
        |> return_json(422, %{message: reason})
    end
  end

  get "/:shortcode" do
    UrlShortener.Converter.to_long(shortcode)
    |> case do
      {:error, reason} ->
        conn
        |> return_json(204, %{message: reason})

      {:ok, url} ->
        conn
        |> Plug.Conn.resp(:found, "")
        |> Plug.Conn.put_resp_header("location", url)
    end
  end

  match _ do
    send_resp(conn, 404, "oops... Nothing here :(")
  end

  def return_json(conn, status, map) do
    send_resp(conn, status, map |> Poison.encode!())
  end
end
