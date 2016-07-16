defmodule Challenge1 do
  def convert_hex_to_base64(string) do
    string
    |> Base.decode16!(case: :mixed)
    |> Base.encode64
  end
end
