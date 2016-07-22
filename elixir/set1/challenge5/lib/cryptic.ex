defmodule Cryptic do
  @all_single_bytes 0..255 |> Enum.map(&(<<&1>>))

  @doc """
  Encrypt the given `plaintext` with the given `key`.

  To encrypt the plaintext this function cycles through each byte of the key
  and sequentially XORs them against the bytes of plaintext.

  For example, with the plaintext `testing 123` and the key `foo`:

    testing 123
    foofoofoofo
  """
  def repeating_key_xor(plaintext, key) do
    plaintext = String.trim_trailing(plaintext)
    Stream.cycle(key |> String.split("") |> List.delete_at(-1))
    |> Enum.take(byte_size(plaintext))
    |> :crypto.exor(plaintext)
    |> Base.encode16(case: :lower)
  end

  @doc """
  XOR each byte of the given binary against given byte.
  """
  def single_byte_xor(binary, key) when byte_size(key) == 1 do
    :crypto.exor(binary, List.duplicate(key, byte_size(binary)))
  end

  def single_byte_xor(_binary, _key) do
    {:error, "key must be a single byte"}
  end

  @doc """
  Finds the most likely ASCII from a given list of binaries.

  ## Examples

      # <<70, 79, 79>> == "FOO"
      iex> Cryptic.most_likely_ascii([<<255>>, <<70, 79, 79>>, <<31>>])
      "FOO"
  """
  def most_likely_ascii(binaries) do
    case binaries |> Enum.filter(&String.printable?/1) do
      printable when length(printable) > 0 ->
        printable
        |> Enum.map(fn(possible) -> {possible, ascii_score(possible)} end)
        |> Enum.max_by(fn({_binary, score}) -> score end)
        |> Tuple.to_list
        |> List.first
      _no_printable ->
        {:error, "No valid ASCII"}
    end
  end

  @doc """
  Score the given binary's possibility of being ASCII text.
  """
  def ascii_score(binary) do
    binary
    |> String.codepoints
    |> do_ascii_score
  end

  @doc """
  Return all single bytes.
  """
  def all_single_bytes do
    @all_single_bytes
  end

  @doc """
  Decode the given string as hex bytes.
  """
  def decode_hex(string) do
    Base.decode16!(string, case: :mixed)
  end

  # internal functions

  defp do_ascii_score(codepoints) do
    do_ascii_score(codepoints, 0)
  end

  defp do_ascii_score([], score) do
    score
  end

  defp do_ascii_score([codepoint | rest], score) do
    score = score + codepoint_score(codepoint)
    do_ascii_score(rest, score)
  end

  defp codepoint_score(" ") do
    2 # weight spaces because they are more likely valid ASCII
  end

  defp codepoint_score(codepoint) do
    if String.printable?(codepoint) do
      1
    else
      0
    end
  end
end
