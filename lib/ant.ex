defmodule Ant do
  def start(config) do
    ant_id = World.spawn(config[:nest_id])
    state = Map.merge(config, %{id: ant_id, location: {0, 0}, home: {0, 0}})
    spawn(fn -> loop(state) end)
  end

  def loop(state) do
    receive do
      message -> handle(message, state)
    end
  end

  def handle(:move, state = %{got_food: true}) do
    Direction.to(state[:location], state[:home])
    |> move_towards(state)
  end

  def handle(:move, state) do
    direction = Direction.to(state[:location], state[:target])
    if direction == :arrived do
      loop(state)
    else
      move_towards(direction, state)
    end
  end

  def handle({:target, location}, state) do
    loop(Map.put(state, :target, location))
  end

  defp move_towards(direction, state) do
    new_state = World.go(state[:id], direction)
    :timer.sleep(1000)
    send self(), :move
    loop(Map.merge(state, new_state))
  end
end
