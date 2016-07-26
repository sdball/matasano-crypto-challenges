defmodule Cryptic do

  def score_each_deciphering(binaries) do
    case binaries |> Enum.filter(&String.printable?/1) do
      printable when length(printable) > 0 ->
        printable
        |> Enum.map(fn(possible) -> {possible, AsciiScore.calculate(possible)} end)
        |> Enum.max_by(fn({_binary, score}) -> score end)
        |> Tuple.to_list
        |> List.first
      _no_printable ->
        {:error, "No valid ASCII"}
    end
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
        |> Enum.map(fn(possible) -> {possible, AsciiScore.calculate(possible)} end)
        |> Enum.max_by(fn({_binary, score}) -> score end)
        |> Tuple.to_list
        |> List.first
      _no_printable ->
        {:error, "No valid ASCII"}
    end
  end

end
