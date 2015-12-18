defmodule Ant do
  def start(config) do
    ant_id = World.spawn(config[:nest_id])
    state = Map.merge(config, %{id: ant_id, location: {0, 0}, home: {0, 0}})
    spawn(fn -> loop(state) end)
  end

  def loop(state) do
    receive do
      :move              -> move(state)
      :go_home           -> go_home(state)
      :random_target     -> random_target(state)
      {:target, target}  -> set_target(state, target)
    end
  end

  def go_home(state) do
    Direction.to(state[:location], state[:home])
    |> move_towards(state)
  end

  def random_target(state) do
    set_target(state, Direction.random_target)
  end

  def move(state) do
    Direction.to(state[:location], state[:target])
    |> move_towards(state)
  end

  def set_target(state, location) do
    proceed(Map.put(state, :target, location))
  end

  defp move_towards(direction, state) do
    new_state = World.go(state[:id], direction)
    proceed(Map.merge(state, new_state))
  end

  defp proceed(state = %{got_food: true}) do
    send self(), :go_home
    loop(state)
  end

  defp proceed(state = %{location: pos, target: pos}) do
    send self(), :random_target
    loop(state)
  end

  defp proceed(state) do
    send self(), :move
    loop(state)
  end
end
