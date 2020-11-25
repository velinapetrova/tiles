defmodule TilesWeb.PageLive do
  use TilesWeb, :live_view

  @number_of_tiles 16

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, number_of_tiles: @number_of_tiles)}
  end
end
