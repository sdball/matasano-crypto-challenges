defmodule Challenge2 do
  use Bitwise

  @doc """
  Performs bit-wise XOR (exclusive or) on the given binaries `left` and `right`.

  The two arguments must be the same byte size.
  """
  def fixed_xor(left, right) when byte_size(left) == byte_size(right) do
    left = decode_hex(left)
    right = decode_hex(right)

    # :crypto.exor(left, right)
    do_fixed_xor(left, right, "")
    |> encode_hex
  end

  @doc """
  Returns an error because the arguments are not the same byte size.
  """
  def fixed_xor(_left, _right) do
    {:error, "Byte length of arguments does not match."}
  end

  defp do_fixed_xor("", "", output) do
    output
  end

  defp do_fixed_xor(<<l_head, l_tail::binary>>, <<r_head, r_tail::binary>>, output) do
    next_byte = <<bxor(l_head, r_head)>>
    do_fixed_xor(l_tail, r_tail, output <> next_byte)
  end

  defp decode_hex(string) do
    Base.decode16!(string, case: :mixed)
  end

  defp encode_hex(string) do
    Base.encode16(string, case: :lower)
  end
end
