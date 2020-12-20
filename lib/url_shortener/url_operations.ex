defmodule UrlShortener.UrlOperations do
  @moduledoc "Converts long url to short and shor url to long"

  require Logger

  def sanitize(url) when is_binary(url), do: url |> String.downcase() |> String.trim() |> trim()
  def sanitize(pass), do: pass

  defp trim("//" <> rest), do: trim(rest)
  defp trim("http:" <> rest), do: trim(rest)
  defp trim("https:" <> rest), do: trim(rest)
  defp trim("www." <> rest), do: trim(rest)
  defp trim("." <> rest), do: trim(rest)
  defp trim(pass), do: pass |> String.trim()

  def is_valid?(""), do: false

  def is_valid?(url) when is_binary(url) do
    # very simple url "check"
    url =~ "."
  end

  def is_valid?(_), do: false
end
