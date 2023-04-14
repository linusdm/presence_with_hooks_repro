defmodule ReproWeb.Presence do
  @moduledoc """
  Provides presence tracking to channels and processes.

  See the [`Phoenix.Presence`](https://hexdocs.pm/phoenix/Phoenix.Presence.html)
  docs for more details.
  """
  use Phoenix.Presence,
    otp_app: :repro,
    pubsub_server: Repro.PubSub

  import Phoenix.LiveView

  @topic "some_topic"

  def on_mount(:default, _params, _session, socket) do
    socket = stream(socket, :users, [])

    socket =
      if connected?(socket) do
        current_user = socket.assigns.current_user

        {:ok, _} = ReproWeb.Presence.track(self(), @topic, current_user.id, current_user)

        Phoenix.PubSub.subscribe(Repro.PubSub, @topic)

        socket
        |> attach_hook(:track_presence_hook, :handle_info, &handle_presence_diff/2)
        |> register_current_presences(@topic)
      else
        socket
      end

    {:cont, socket}
  end

  defp register_current_presences(socket, topic) do
    ReproWeb.Presence.list(topic)
    |> Enum.reduce(socket, fn {_id, %{metas: [meta | _]}}, socket ->
      stream_insert(socket, :users, meta)
    end)
  end

  def handle_presence_diff(%Phoenix.Socket.Broadcast{event: "presence_diff"} = msg, socket) do
    socket = socket |> handle_joins(msg.payload) |> handle_leaves(msg.payload)
    {:cont, socket}
  end

  def handle_presence_diff(_msg, socket) do
    {:cont, socket}
  end

  defp handle_joins(socket, %{joins: joins}) do
    Enum.reduce(joins, socket, fn {_id, %{metas: [meta | _]}}, socket ->
      stream_insert(socket, :users, meta)
    end)
  end

  defp handle_leaves(socket, %{leaves: leaves}) do
    Enum.reduce(leaves, socket, fn {_id, %{metas: [meta | _]}}, socket ->
      stream_delete(socket, :users, meta)
    end)
  end
end
