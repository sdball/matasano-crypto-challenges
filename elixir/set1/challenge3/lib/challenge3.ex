defmodule Challenge3 do
  @all_single_hex_bytes 0..255 |> Enum.map(&(<<&1>>))

  @doc """
  Finds the most likely deciphering of a single byte XOR for the given `ciphertext`.
  """
  def decipher_single_byte_xor(ciphertext) do
    ciphertext = decode_hex(ciphertext)
    @all_single_hex_bytes
    |> Enum.map(fn(key) -> single_byte_xor(ciphertext, key) end)
    |> Enum.filter(&(String.printable?(&1)))
    |> most_likely_ascii
  end

  @doc """
  XOR each byte of the given binary against the single byte key.
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
      iex> Challenge3.most_likely_ascii([<<255>>, <<70, 79, 79>>, <<31>>])
      "FOO"
  """
  def most_likely_ascii(binaries) do
    {most_likely_ascii, _ascii_score} = binaries
    |> Enum.map(fn(possible) -> {possible, ascii_score(possible)} end)
    |> Enum.max_by(fn({_binary, score}) -> score end)

    most_likely_ascii
  end

  @doc """
  Score the given binary's possibility of being ASCII text.
  """
  def ascii_score(binary) do
    # printable_score(binary) + spaces_score(binary)
    # binary |> String.codepoints |> Enum.map(&(codepoint_score(&1))) |> Enum.sum
    # Enum.reduce([1, 2, 3, 4], fn(x, acc) -> x * acc end)
    # binary |> String.codepoints |> Enum.reduce(0, fn(c,score) -> score + codepoint_score(c) end)
    do_ascii_score(binary |> String.codepoints, 0)
  end

  def do_ascii_score([], score) do
    score
  end

  def do_ascii_score([codepoint | rest], score) do
    score = score + codepoint_score(codepoint)
    do_ascii_score(rest, score)
  end

  def codepoint_score(" ") do
    2 # weight spaces because they are more likely valid ASCII
  end

  def codepoint_score(codepoint) do
    if String.printable?(codepoint) do
      1
    else
      0
    end
  end

  def printable_score(binary) do
    binary
    |> String.codepoints
    |> Enum.count(fn(codepoint) -> codepoint >= " " && codepoint <= "~" end)
  end

  def spaces_score(binary) do
    binary
    |> String.codepoints
    |> Enum.count(fn(codepoint) -> codepoint == " " end)
  end

  def all_single_hex_bytes do
    @all_single_hex_bytes
  end

  def decode_hex(string) do
    Base.decode16!(string, case: :mixed)
  end
end
