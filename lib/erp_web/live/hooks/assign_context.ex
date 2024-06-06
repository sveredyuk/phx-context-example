defmodule ErpWeb.Live.Hooks.AssignContext do
  import Phoenix.Component, only: [assign: 2]

  def on_mount(:default, _params, %{"current_user" => user}, socket) do
    permissions = Erp.Permissions.build(user)
    ctx = %Erp.Context{user: user, permissions: permissions}

    {:cont, assign(socket, ctx: ctx)}
  end

  def on_mount(:default, _params, _sesssion, socket) do
    {:cont, socket}
  end
end
