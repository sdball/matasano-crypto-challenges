defmodule AsciiScore do
  @doc """
  Score the given binary's possibility of being ASCII text.
  """
  def calculate(binary) do
    case String.printable?(binary) do
      true ->
        binary
        |> String.to_charlist
        |> ascii_score
      false ->
        0
    end
  end

  def ascii_score(bytes) do
    ascii_score(bytes, 0)
  end

  def ascii_score([], score) do
    score
  end

  def ascii_score([byte | rest], score) do
    score = score + byte_score(byte)
    ascii_score(rest, score)
  end

  def byte_score(" ") do
    2
  end

  def byte_score(byte) when byte >= ?A and byte <= ?Z do
    2
  end

  def byte_score(byte) when byte >= ?a and byte <= ?z do
    2
  end

  def byte_score(_byte) do
    0
  end
end
