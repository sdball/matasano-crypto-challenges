defmodule Challenge3 do
  import Cryptic

  @doc """
  Finds the most likely deciphering of a single byte XOR for the given `ciphertext`.
  """
  def decipher_single_byte_xor(ciphertext) do
    ciphertext = decode_hex(ciphertext)
    all_single_bytes
    |> Enum.map(fn(key) -> single_byte_xor(ciphertext, key) end)
    |> most_likely_ascii
  end
end
