defmodule UrlShortener.Repo.Migrations.Initial do
  use Ecto.Migration

  def change do
    create table(:urls) do
      add :long, :string, null: false
    end
  end
end
