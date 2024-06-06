defmodule Erp.Inventory.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :name, :string
    field :price, :decimal
    field :sku, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:sku, :name, :price])
    |> validate_required([:sku, :name, :price])
  end
end
