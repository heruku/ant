defmodule DirectionTest do
  use ExUnit.Case

  test "when at the final location" do
    assert Direction.to({0, 0}, {0, 0}) == :arrived
  end

  test "walks north" do
    assert Direction.to({0, 0}, {0, -1}) == :n
  end

  test "walks south" do
    assert Direction.to({0, 0}, {0, 1}) == :s
  end

  test "walks west" do
    assert Direction.to({0, 0}, {-1, 0}) == :w
  end

  test "walks east" do
    assert Direction.to({0, 0}, {1, 0}) == :e
  end

  test "walks north-west" do
    assert Direction.to({0, 0}, {-1, -1}) == :nw
  end

  test "walks south-west" do
    assert Direction.to({0, 0}, {-1, 1}) == :sw
  end

  test "walks north-east" do
    assert Direction.to({0, 0}, {1, -1}) == :ne
  end

  test "walks south-east" do
    assert Direction.to({0, 0}, {1, 1}) == :se
  end
end
