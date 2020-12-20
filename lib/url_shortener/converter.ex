defmodule UrlShortener.Converter do
  @moduledoc "Casts long url to shortcode or vice versa"

  alias UrlShortener.UrlOperations

  @doc "Checks for shortcode in DB and returns long url if exsits"
  @spec to_long(binary()) :: {:ok, binary()} | {:error, binary()}
  def to_long(short_code) do
    short_code
    |> Base62.decode()
    |> get_url()
    |> case do
      %{long: long} ->
        {:ok, "http://#{long}"}

      _ ->
        {:error, "Url not found"}
    end
  end

  @doc "Creates shortcode for long url and returns it"
  @spec to_short(binary()) :: {:ok, binary()} | {:error, binary()}
  def to_short(long_url) do
    cond do
      UrlOperations.is_valid?(long_url) ->
        long_url
        |> UrlOperations.sanitize()
        |> insert_or_get()
        |> case do
          {:ok, %{id: id}} ->
            {:ok, "http://#{host()}:#{port()}/#{Base62.encode(id)}"}

          _ ->
            # TODO: add better error description
            {:error, "Insert failed"}
        end

      true ->
        {:error, "Invalid url #{long_url}"}
    end
  end

  defp host, do: UrlShortener.http_config()[:host]

  defp port, do: UrlShortener.http_config()[:port]

  defp get_url({:ok, id}) do
    UrlShortener.Repo.get(UrlShortener.Models.Url, id)
  end

  defp get_url(pass), do: pass

  defp insert_or_get(long_url) do
    UrlShortener.Models.Url
    |> UrlShortener.Repo.get_by(long: long_url)
    |> case do
      nil ->
        UrlShortener.Repo.insert(%UrlShortener.Models.Url{long: long_url})

      url ->
        {:ok, url}
    end
  end
end
