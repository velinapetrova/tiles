defmodule TileComponent do
  use TilesWeb, :live_component

  def render(assigns) do
    Phoenix.View.render(TilesWeb.PageView, "tile.html", assigns)
  end
end
