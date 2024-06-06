defmodule ErpWeb.ItemLive.Show do
  use ErpWeb, :live_view

  alias Erp.Inventory

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, %{assigns: %{ctx: ctx}} = socket) do
    ctx
    |> Inventory.fetch_item(id)
    |> case do
      {:ok, item} ->
        {:noreply,
         socket
         |> assign(:page_title, page_title(socket.assigns.live_action))
         |> assign(:item, item)}

      {:error, :not_found} ->
        socket
        |> put_flash(:error, "Not found")

      {:error, :not_authorized} ->
        socket
        |> put_flash(:error, "Forbidden")
    end
  end

  defp page_title(:show), do: "Show Item"
  defp page_title(:edit), do: "Edit Item"
end
