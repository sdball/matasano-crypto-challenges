defmodule Challenge6Test do
  use ExUnit.Case
  doctest Challenge6

  describe ".transpose_blocks/2" do
    test "it rearranges the bytes according to the given size" do
      bytes = <<1,2,3,4>>
      size = 2
      expected = [<<1,3>>, <<2,4>>]
      assert Challenge6.transpose_blocks(bytes, size) == expected
    end
  end
end
