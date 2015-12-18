defmodule Direction do
  def to({x, y}, {x, y}), do: :arrived

  def to({x1, y1}, {x2, y2}) do
    delta_x = x2 - x1
    delta_y = y2 - y1

    cond do
      delta_y < 0 && delta_x < 0 -> :nw
      delta_y > 0 && delta_x < 0 -> :sw
      delta_y < 0 && delta_x > 0 -> :ne
      delta_y > 0 && delta_x > 0 -> :se
      delta_y < 0 -> :n
      delta_y > 0 -> :s
      delta_x < 0 -> :w
      delta_x > 0 -> :e
    end
  end
end
