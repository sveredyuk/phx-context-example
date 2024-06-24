defmodule Erp.Permissions do
  defstruct read_items: false, create_items: false, update_items: false, delete_items: false

  alias Erp.Context

  def build(%Erp.Accounts.User{role: :supervisor}) do
    %__MODULE__{
      read_items: true,
      create_items: true,
      update_items: true,
      delete_items: true
    }
    |> Map.from_struct()
  end

  def build(%Erp.Accounts.User{role: :manager}) do
    %__MODULE__{
      read_items: true,
      create_items: true,
      update_items: true
    }
    |> Map.from_struct()
  end

  def build(%Erp.Accounts.User{role: :worker}) do
    %__MODULE__{
      read_items: true
    }
    |> Map.from_struct()
  end

  def can?(%Context{permissions: permissions}, action) do
    permissions[action] == true
  end

  def authorize(%Context{} = ctx, action) do
    ctx
    |> can?(action)
    |> case do
      true -> {:ok, :authorized}
      false -> {:error, :not_authorized}
    end
  end
end
