defmodule SingleByteXorTest do
  use ExUnit.Case

  describe "SingleByteXor.xor/2" do
    test "performs an xor of the key against each byte of the given binary" do
      text = "qpssp"
      key = <<9>>
      assert SingleByteXor.xor(text, key) == "xyzzy"
    end
  end

  describe "SingleByteXor.break/1" do
    test "it finds the key that yields the most probable deciphering" do
      assert %{decipher: decipher, key: key} = SingleByteXor.break("hello there")
      assert decipher == "hello there"
      assert key == <<0>>

      plaintext = "hello old friend"
      key = <<7>>
      ciphertext = SingleByteXor.xor(plaintext, key)
      assert %{decipher: decipher, key: key} = SingleByteXor.break(ciphertext)
      assert decipher == plaintext
      assert key == key
    end
  end

  describe "SingleByteXor.xor_against_every_byte/1" do
    test "XOR each byte against the ciphertext" do
      assert Enum.count(SingleByteXor.xor_every_byte("hi")) == 256
      expected_first_two = [
        %Deciphering{score: 0, ciphertext: "hi", decipher: "hi", key: <<0>>},
        %Deciphering{score: 0, ciphertext: "hi", decipher: "ih", key: <<1>>}
      ]
      first_two = SingleByteXor.xor_every_byte("hi") |> Enum.take(2)
      assert first_two == expected_first_two
    end
  end

end
