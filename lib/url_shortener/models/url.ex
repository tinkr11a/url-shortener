defmodule UrlShortener.Models.Url do
  use Ecto.Schema

  schema "urls" do
    field(:long, :string)
  end
end
