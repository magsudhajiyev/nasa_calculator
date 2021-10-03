defmodule NASACalcTest do
  use ExUnit.Case
  doctest NASACalc

  test "greets the world" do
    assert NASACalc.hello() == :world
  end
end
