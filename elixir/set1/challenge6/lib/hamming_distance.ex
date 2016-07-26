defmodule HammingDistance do
  @moduledoc """
  Hamming Distance is a count of differing bits between two sets of bytes.
  """

  @doc """
  Count the number of differing bits between two binaries.
  """
  def calculate(string1, string2) when byte_size(string1) == byte_size(string2) do
    [string1, string2]
    |> Enum.map(&string_to_bits/1)
    |> List.zip |> Enum.count(fn(pair) -> {a,b} = pair; a != b end)
  end

  def string_to_bits(string) do
    string
    |> String.to_charlist
    |> Enum.map(&(Integer.digits(&1, 2)))
    |> Enum.map(&left_pad_to_byte/1)
    |> List.flatten
  end

  @doc """
  Left pad the `bits` array with 0 values until there are 8 bits.
  """
  def left_pad_to_byte(bits) when length(bits) == 8 do
    bits
  end

  def left_pad_to_byte(bits) when length(bits) < 8 do
    left_pad_to_byte([0 | bits])
  end
end
