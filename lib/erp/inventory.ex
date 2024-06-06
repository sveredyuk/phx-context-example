defmodule Erp.Inventory do
  @moduledoc """
  The Inventory context.
  """

  import Ecto.Query, warn: false
  alias Erp.Repo
  alias Erp.Context
  alias Erp.Inventory.Item

  def list_items(%Context{} = ctx) do
    with {:ok, :authorized} <- Erp.Permissions.authorize(ctx, :read_items) do
      Repo.all(Item)
    end
  end

  def fetch_item(%Context{} = ctx, id) do
    with {:ok, :authorized} <- Erp.Permissions.authorize(ctx, :read_items) do
      Repo.fetch(Item, id)
    end
  end

  def create_item(%Context{} = ctx, attrs \\ %{}) do
    with {:ok, :authorized} <- Erp.Permissions.authorize(ctx, :create_items) do
      %Item{}
      |> Item.changeset(attrs)
      |> Repo.insert()
    end
  end

  def update_item(%Context{} = ctx, %Item{} = item, attrs) do
    with {:ok, :authorized} <- Erp.Permissions.authorize(ctx, :update_items) do
      item
      |> Item.changeset(attrs)
      |> Repo.update()
    end
  end

  def delete_item(%Context{} = ctx, %Item{} = item) do
    with {:ok, :authorized} <- Erp.Permissions.authorize(ctx, :delete_items) do
      Repo.delete(item)
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking item changes.

  ## Examples

      iex> change_item(item)
      %Ecto.Changeset{data: %Item{}}

  """
  def change_item(%Item{} = item, attrs \\ %{}) do
    Item.changeset(item, attrs)
  end
end
