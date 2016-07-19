defmodule Challenge3Test do
  use ExUnit.Case
  doctest Challenge3

  describe "decipher_single_byte_xor/1" do
    test "finds the most likely ascii single byte xor of the given cipher" do
      text = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"
      expected = "Cooking MC's like a pound of bacon"
      assert Challenge3.decipher_single_byte_xor(text) == expected
    end
  end
end
