defmodule Challenge6 do
  def break_repeating_key_xor(filename) do
    ciphertext = decode_file(filename)

    find_probable_keysizes(ciphertext, 3)
    |> Enum.map(&(transpose_blocks(ciphertext, &1)))
    |> Enum.map(&IO.inspect/1)
  end

  def transpose_blocks(ciphertext, keysize) do
    ciphertext
    |> String.codepoints
    |> Enum.chunk(keysize)
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.join(&1, ""))
  end

  def find_probable_keysizes(encrypted, count) do
    (2..40)
    |> Enum.map(&Task.async(__MODULE__, :hamming_distance, [encrypted, &1]))
    |> Enum.map(&Task.await(&1))
    |> Enum.sort_by(fn(pair) -> {result, _guess} = pair; result end)
    |> Enum.take(count)
    |> Enum.map(fn(pair) -> {_result, guess} = pair; guess end)
  end

  def hamming_distance(encrypted, guess) do
    encrypted
    |> String.codepoints
    |> Stream.chunk(guess)
    |> Enum.take(2)
    |> Enum.map(&(Enum.join(&1, "")))
    |> hamming_distance
    |> normalize_result(guess)
    |> pair_result(guess)
  end

  def hamming_distance([string1, string2]) do
    HammingDistance.calculate(string1, string2)
  end

  def decode_file(filename) do
    filename
    |> File.read!
    |> String.split("\n")
    |> Enum.join("")
    |> Base.decode64!
  end

  # -- internal --------------------------------------------------------------

  defp normalize_result(hamming_distance, guess) do
    hamming_distance / guess
  end

  defp pair_result(result, extra) do
    {result, extra}
  end
end
