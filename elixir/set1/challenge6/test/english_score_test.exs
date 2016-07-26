defmodule EnglishScoreTest do
  use ExUnit.Case

  test "it properly scores basic strings" do
    assert EnglishScore.calculate("hello") == 34
    assert EnglishScore.calculate("HELLO") == 34
  end
end
