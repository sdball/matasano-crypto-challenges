defmodule Challenge1 do
  def convert_hex_to_base64(string) do
    string
    |> decode_hex
    |> encode_base64
  end

  defp decode_hex(string) do
    Base.decode16!(string, case: :mixed)
  end

  defp encode_base64(string) do
    Base.encode64(string)
  end
end
