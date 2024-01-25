defmodule DotpTest do
  use ExUnit.Case
  doctest Dotp

  test "greets the world" do
    assert Dotp.hello() == :world
  end
end
