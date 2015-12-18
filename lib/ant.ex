defmodule Ant do
  def start(config) do
    ant_id = World.spawn(config[:nest_id])
    state = Map.merge(config, %{id: ant_id, location: {0, 0}, home: {0, 0}})
    spawn(fn -> loop(state) end)
  end

  def loop(state) do
    receive do
      :move    -> move(state)
      :go_home -> go_home(state)
      {:target, target}  -> set_target(state, target)
    end
  end

  def go_home(state) do
    Direction.to(state[:location], state[:home])
    |> move_towards(state)
  end

  def move(state) do
    direction = Direction.to(state[:location], state[:target])
    if direction == :arrived do
      send self(), {:target, Direction.random_target}
      loop(state)
    else
      move_towards(direction, state)
    end
  end

  def set_target(state, location) do
    proceed(Map.put(state, :target, location))
  end

  defp move_towards(direction, state) do
    new_state = World.go(state[:id], direction)
    :timer.sleep(1000)
    proceed(Map.merge(state, new_state))
  end

  defp proceed(state = %{got_food: true}) do
    send self(), :go_home
    loop(state)
  end

  defp proceed(state) do
    send self(), :move
    loop(state)
  end
end
