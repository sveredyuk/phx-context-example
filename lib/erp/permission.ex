defmodule Erp.Permissions do
  defstruct read_items: false, create_items: false, update_items: false, delete_items: false

  def build(%Erp.Accounts.User{role: :supervisor}) do
    %__MODULE__{
      read_items: true,
      create_items: true,
      update_items: true,
      delete_items: true
    }
  end

  def build(%Erp.Accounts.User{role: :manager}) do
    %__MODULE__{
      read_items: true,
      create_items: true,
      update_items: true
    }
  end

  def build(%Erp.Accounts.User{role: :worker}) do
    %__MODULE__{
      read_items: true
    }
  end
end
