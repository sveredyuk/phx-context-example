defmodule Erp.Repo do
  use Ecto.Repo,
    otp_app: :erp,
    adapter: Ecto.Adapters.Postgres

  def fetch(schema, id) do
    schema
    |> __MODULE__.get(id)
    |> case do
      nil -> {:error, :not_found}
      struct -> {:ok, struct}
    end
  end
end
