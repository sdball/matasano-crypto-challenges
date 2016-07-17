defmodule Challenge2Test do
  use ExUnit.Case
  doctest Challenge2

  test "fixed xor" do
    left     = "1c0111001f010100061a024b53535009181c"
    right    = "686974207468652062756c6c277320657965"
    expected = "746865206b696420646f6e277420706c6179"

    assert Challenge2.fixed_xor(left, right) == expected
  end

  test "byte mismatch between left and right raises an error" do
    left  = "abcd"
    right = "abc"
    assert_raise ArgumentError, fn ->
      Challenge2.fixed_xor(left, right)
    end
  end
end
