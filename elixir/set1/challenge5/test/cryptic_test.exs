defmodule CrypticTest do
  use ExUnit.Case
  doctest Cryptic

  describe "Cryptic.single_byte_xor/2" do
    test "performs an xor of the key against each byte of the given binary" do
      text = "qpssp"
      key = <<9>>
      assert Cryptic.single_byte_xor(text, key) == "xyzzy"
    end
  end

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

  describe "Cryptic.ascii_score/1" do
    test "properly scores valid ascii" do
      assert Cryptic.ascii_score("foo") == 3
      assert Cryptic.ascii_score(<<0,70,71>>) == 2
      assert Cryptic.ascii_score("maybeascii") == 10
      assert Cryptic.ascii_score("very likely ascii") == 19
    end
  end
end
