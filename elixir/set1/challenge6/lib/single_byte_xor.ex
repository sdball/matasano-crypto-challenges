defmodule SingleByteXor do
  @single_bytes 0..255 |> Enum.map(&(<<&1>>))

  def single_bytes do
    @single_bytes
  end

  @doc """
  XOR each byte of the given binary against the given byte key.
  """
  def xor(binary, key) do
    :crypto.exor(binary, List.duplicate(key, byte_size(binary)))
  end

  def break(ciphertext) do
    single_bytes
    |> Enum.map(fn(byte) ->
      %Deciphering{key: byte, ciphertext: ciphertext, decipher: xor(ciphertext, byte)}
    end)
    |> calculate_score
    |> find_most_likely_deciphering
  end

  def xor_every_byte(ciphertext) do
    single_bytes
    |> Enum.map(fn(key) -> %Deciphering{ciphertext: ciphertext, decipher: xor(ciphertext, key), key: key} end)
  end

  def calculate_score(decipherings) when is_list(decipherings) do
    decipherings
    |> Enum.map(&calculate_score/1)
  end

  def calculate_score(%{decipher: decipher} = deciphering) do
    deciphering
    |> Map.put(:score, EnglishScore.calculate(decipher))
  end

  def find_most_likely_deciphering(decipherings) when is_list(decipherings) do
    decipherings
    |> Enum.max_by(fn deciphering -> deciphering.score end)
  end
end
