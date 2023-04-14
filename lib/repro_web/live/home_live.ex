defmodule ReproWeb.HomeLive do
  use ReproWeb, :live_view

  on_mount ReproWeb.Presence

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Welcome home young Padawans!</h1>
    <ul id="presences" phx-update="stream">
      <li :for={{dom_id, user} <- @streams.users} id={dom_id}>
        <%= user.email %>
      </li>
    </ul>
    """
  end
end
