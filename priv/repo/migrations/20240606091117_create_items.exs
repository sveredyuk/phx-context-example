defmodule Erp.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :sku, :string
      add :name, :string
      add :price, :decimal

      timestamps(type: :utc_datetime)
    end
  end
end
