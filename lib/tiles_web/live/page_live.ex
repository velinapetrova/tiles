defmodule TilesWeb.PageLive do
  use TilesWeb, :live_view

  @number_of_pairs 8

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(tiles: generate_tiles())

    {:ok, socket}
  end

  defp generate_tiles do
    generate_values()
    |> Enum.map(&(%{state: "closed", value: &1}))
  end

  defp generate_values do
    values()
    |> Enum.concat(values())
    |> Enum.shuffle()
  end

  defp values do
    Enum.to_list(1..@number_of_pairs)
  end
end
