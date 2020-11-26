defmodule TilesWeb.PageLive do
  use TilesWeb, :live_view

  alias Tiles.Tile

  @number_of_pairs 8

  @impl true
  def mount(_params, _session, socket) do
    {:ok, setup_game(socket)}
  end

  @impl true
  def handle_event("new-game", _value, socket) do
    {:noreply, setup_game(socket)}
  end

  defp setup_game(socket) do
    socket
    |> assign(tiles: generate_tiles())
    |> assign(selected_tile: nil)
    |> assign(remaining_pairs: @number_of_pairs)
  end

  @impl true
  def handle_info({:tile_selected, id, value}, socket) do
    send_update TileComponent, id: id, state: "opened", value: value

    case socket.assigns.selected_tile do
      nil ->
        {:noreply, assign(socket, selected_tile: %{id: id, value: value})}
      _ ->
        Process.send_after(self(), {:validate_pair, id, value}, 500)
        {:noreply, socket}
    end
  end

  def handle_info({:validate_pair, id, value}, socket) do
    selected_tile = socket.assigns.selected_tile

    if selected_tile.value == value do
      {:noreply, assign(socket, selected_tile: nil, remaining_pairs: socket.assigns.remaining_pairs - 1)}
    else
      send_update TileComponent, id: id, state: "closed", value: value
      send_update TileComponent, id: selected_tile.id, state: "closed", value: selected_tile.value
      {:noreply, assign(socket, selected_tile: nil)}
    end
  end

  defp generate_tiles do
    generate_values()
    |> Enum.map(&(%Tile{id: generate_id(), value: &1}))
  end

  defp generate_values do
    values()
    |> Enum.concat(values())
    |> Enum.shuffle()
  end

  defp values do
    Enum.to_list(1..@number_of_pairs)
  end

  defp generate_id do
    "id-#{Enum.random(0..100000)}"
  end
end
