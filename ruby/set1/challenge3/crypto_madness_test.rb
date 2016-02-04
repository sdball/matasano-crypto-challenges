#!/usr/bin/env ruby

require_relative 'crypto_madness'
require 'minitest/autorun'

describe CryptoMadness::HexString do
  subject { CryptoMadness::HexString.new(raw_string) }

  describe "hex to base64" do
    let(:raw_string) { "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d" }

    describe "#to_ascii" do
      it "converts hex to ascii" do
        expected_ascii = "I'm killing your brain like a poisonous mushroom"
        subject.to_ascii.must_equal expected_ascii
      end
    end

    describe "#to_base64" do
      it "converts hex to base64" do
        expected_base64 = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"
        subject.to_base64.must_equal expected_base64
      end
    end
  end
end

describe CryptoMadness do
  describe ".fixed_xor" do
    it "takes two equal-length buffers and produces their XOR combination" do
      buffer1 = "1c0111001f010100061a024b53535009181c"
      buffer2 = "686974207468652062756c6c277320657965"
      expected_xor = "746865206b696420646f6e277420706c6179"

      CryptoMadness.fixed_xor(buffer1, buffer2).must_equal expected_xor
    end
  end

  describe ".decipher_single_byte_xor" do
    it "finds the most likely ascii deciphering of the given cipher string" do
      cipher = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"
      CryptoMadness.decipher_single_byte_xor(cipher).must_equal "Cooking MC's like a pound of bacon"
    end
  end

  describe ".xor_string" do
    it "does an XOR of the key against every byte of the given string" do
      CryptoMadness.xor_string("qpssp", 9).must_equal "xyzzy"
    end
  end

  describe ".most_likely_ascii" do
    it "finds the most ascii-like from the given array of strings" do
      actual_phrase = "A winner is you!"
      ciphers = 0.upto(255).map { |key| CryptoMadness.xor_string(actual_phrase, key) }
      ciphers << actual_phrase

      CryptoMadness.most_likely_ascii(ciphers).must_equal actual_phrase
    end
  end
end

