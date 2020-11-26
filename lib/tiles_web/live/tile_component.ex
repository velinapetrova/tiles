defmodule TileComponent do
  use TilesWeb, :live_component

  def render(assigns) do
    Phoenix.View.render(TilesWeb.PageView, "tile.html", assigns)
  end

  def handle_event("select-tile", _value, socket) do
    send self(), {:tile_selected, socket.assigns.id, socket.assigns.value}
    {:noreply, socket}
  end
end
