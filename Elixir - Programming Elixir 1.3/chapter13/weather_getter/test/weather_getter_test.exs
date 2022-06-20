defmodule WeatherGetterTest do
  use ExUnit.Case
  doctest WeatherGetter

  test "greets the world" do
    assert WeatherGetter.hello() == :world
  end
end
