defmodule AsciiScoreTest do
  use ExUnit.Case

  describe "AsciiScore.calculate/1" do
    test "properly scores valid ascii" do
      assert AsciiScore.calculate("foo") == 3
      assert AsciiScore.calculate(<<0,70,71>>) == 2
      assert AsciiScore.calculate("maybeascii") == 10
      assert AsciiScore.calculate("very likely ascii") == 19
    end
  end
end
