defmodule EnglishScore do
  @doc """
  Score the given binary's possibility of being English text.
  """
  def calculate(binary) do
    case String.printable?(binary) do
      true ->
        binary
        |> String.to_charlist
        |> english_score
      false ->
        0
    end
  end

  def english_score(bytes) do
    english_score(bytes, 0)
  end

  def english_score([], score) do
    score
  end

  def english_score([byte | rest], score) do
    score = score + byte_score(byte)
    english_score(rest, score)
  end

  def byte_score(byte) when byte == ?u or byte == ?U do
    2
  end

  def byte_score(byte) when byte == ?l or byte == ?L do
    3
  end

  def byte_score(byte) when byte == ?d or byte == ?D do
    2
  end

  def byte_score(byte) when byte == ?r or byte == ?R do
    4
  end

  def byte_score(byte) when byte == ?h or byte == ?H do
    5
  end

  def byte_score(byte) when byte == ?s or byte == ?S do
    6
  end

  def byte_score(?\s) do
    7
  end

  def byte_score(byte) when byte == ?n or byte == ?N do
    8
  end

  def byte_score(byte) when byte == ?i or byte == ?I do
    9
  end

  def byte_score(byte) when byte == ?o or byte == ?Odo
    10
  end

  def byte_score(byte) when byte == ?a or byte == ?A do
    11
  end

  def byte_score(byte) when byte == ?t or byte == ?T do
    12
  end

  def byte_score(byte) when byte == ?e or byte == ?E do
    13
  end

  def byte_score(byte) when byte >= ?A and byte <= ?Z do
    1
  end

  def byte_score(byte) when byte >= ?a and byte <= ?z do
    1
  end

  def byte_score(_byte) do
    0
  end
end
