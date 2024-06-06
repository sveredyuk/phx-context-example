defmodule ErpWeb.ItemLive.Index do
  use ErpWeb, :live_view

  alias Erp.Inventory
  alias Erp.Inventory.Item

  @impl true
  def mount(_params, _session, %{assigns: %{ctx: ctx}} = socket) do
    {:ok, stream(socket, :items, Inventory.list_items(ctx))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(%{assigns: %{ctx: ctx}} = socket, :edit, %{"id" => id}) do
    ctx
    |> Inventory.fetch_item(id)
    |> case do
      {:ok, item} ->
        socket
        |> assign(:page_title, "Edit Item")
        |> assign(:item, item)

      {:error, :not_found} ->
        socket
        |> put_flash(:error, "Not found")

      {:error, :not_authorized} ->
        socket
        |> put_flash(:error, "Forbidden")
    end
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Item")
    |> assign(:item, %Item{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Items")
    |> assign(:item, nil)
  end

  @impl true
  def handle_info({ErpWeb.ItemLive.FormComponent, {:saved, item}}, socket) do
    {:noreply, stream_insert(socket, :items, item)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, %{assigns: %{ctx: ctx}} = socket) do
    with {:ok, item} <- Inventory.fetch_item(ctx, id),
         {:ok, _} <- Inventory.delete_item(ctx, item) do
      {:noreply, stream_delete(socket, :items, item)}
    else
      {:error, :not_found} -> {:noreply, put_flash(socket, :error, "Not Found")}
      {:error, :not_authorized} -> {:noreply, put_flash(socket, :error, "Forbidden")}
    end
  end
end
