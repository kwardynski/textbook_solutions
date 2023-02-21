defmodule Chapter11Test do
  use ExUnit.Case
  doctest Chapter11

  test "greets the world" do
    assert Chapter11.hello() == :world
  end
end
