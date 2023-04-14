defmodule ReproWeb.HomeLive do
  use ReproWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    home
    """
  end
end
