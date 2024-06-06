defmodule Erp.InventoryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Erp.Inventory` context.
  """

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        name: "some name",
        price: "120.5",
        sku: "some sku"
      })
      |> Erp.Inventory.create_item()

    item
  end
end
