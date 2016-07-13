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

  describe "Challenge3.single_byte_xor/2" do
    test "performs an xor of the key against each byte of the given binary" do
      text = "qpssp"
      key = <<9>>
      assert Challenge3.single_byte_xor(text, key) == "xyzzy"
    end
  end

  describe "Challenge3.most_likely_ascii/1" do
    test "finds the most ascii-like from a given list of strings" do
      actual_phrase = "A winner is you!"

      possible_ciphers = Challenge3.all_single_hex_bytes
      |> Enum.map(fn(key) -> Challenge3.single_byte_xor(actual_phrase, key) end)

      assert Challenge3.most_likely_ascii(possible_ciphers) == actual_phrase
    end
  end

  describe "Challenge3.ascii_score/1" do
    test "properly scores valid ascii" do
      assert Challenge3.ascii_score("foo") == 3
      assert Challenge3.ascii_score(<<0,70,71>>) == 2
      assert Challenge3.ascii_score("maybeascii") == 10
      assert Challenge3.ascii_score("very likely ascii") == 19
    end
  end
end
