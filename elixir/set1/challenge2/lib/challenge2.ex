defmodule Challenge2 do
  use Bitwise

  def fixed_xor(left, right) do
    left = Base.decode16!(left, case: :mixed)
    right = Base.decode16!(right, case: :mixed)

    # :crypto.exor(left, right)
    do_fixed_xor(left, right, "")
    |> Base.encode16(case: :lower)
  end

  defp do_fixed_xor("", "", result) do
    result
  end

  defp do_fixed_xor(<<left_byte, left::binary>>, <<right_byte, right::binary>>, result) do
    transformed_byte = <<bxor(left_byte, right_byte)>>
    do_fixed_xor(left, right, result <> transformed_byte)
  end
end
