defmodule Challenge4 do
  import Cryptic

  def detect_single_character_xor(filename) do
    File.read!(filename)
    |> String.split("\n")
    |> Enum.map(&decipher_single_byte_xor/1)
    |> Enum.filter(&is_binary/1)
    |> most_likely_ascii
  end

  @doc """
  Find the most likely deciphering of a single byte XOR for the given `ciphertext`.
  """
  def decipher_single_byte_xor(ciphertext) do
    ciphertext = decode_hex(ciphertext)
    all_single_bytes
    |> Enum.map(fn(key) -> single_byte_xor(ciphertext, key) end)
    |> most_likely_ascii
  end
end
