defmodule Challenge4Test do
  use ExUnit.Case
  doctest Challenge4

  describe "Challenge4.detect_single_character_xor/1" do
    test "it reads all strings from the file and finds one encrypted with a single byte" do
      expected = "Now that the party is jumping\n"
      assert Challenge4.detect_single_character_xor("data/4.txt") == expected
    end
  end
end
