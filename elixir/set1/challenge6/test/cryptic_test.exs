defmodule CrypticTest do
  use ExUnit.Case
  doctest Cryptic

  describe "Cryptic.most_likely_ascii/1" do
    test "finds the most ascii-like from a given list of strings" do
      actual_phrase = "A winner is you!"

      possible_ciphers = Cryptic.all_single_bytes
      |> Enum.map(fn(key) -> Cryptic.single_byte_xor(actual_phrase, key) end)

      assert Cryptic.most_likely_ascii(possible_ciphers) == actual_phrase
    end

    test "when there are no printable binaries it returns an error" do
      no_valid_ascii = [<<0>>,<<1>>,<<2>>]
      assert Cryptic.most_likely_ascii(no_valid_ascii) == {:error, "No valid ASCII"}
    end
  end
end
