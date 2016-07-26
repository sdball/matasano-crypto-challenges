defmodule HammingDistanceTest do
  use ExUnit.Case

  describe "HammingDistance.calculate/2" do
    test "it computes the hamming distance between two strings" do
      string1 = "this is a test"
      string2 = "wokka wokka!!!"
      assert HammingDistance.calculate(string1, string2) == 37
    end
  end

  describe "HammingDistance.string_to_bits/1" do
    test "converts string into a list of bits" do
      bytes = "abc"
      expected = [0, 1, 1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 1]
      assert HammingDistance.string_to_bits(bytes) == expected
    end
  end

  describe "HammingDistance.left_pad_to_byte/1" do
    test "when there are fewer than 8 values it left pads with 0 until there are 8" do
      bits = [1,1,0,0]
      assert HammingDistance.left_pad_to_byte(bits) == [0,0,0,0,1,1,0,0]
    end

    test "when there are already 8 values they are returned" do
      bits = [0,0,0,0,0,0,0,1]
      assert HammingDistance.left_pad_to_byte(bits) == bits
    end
  end
end
