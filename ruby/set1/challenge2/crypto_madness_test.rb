#!/usr/bin/env ruby

require_relative 'crypto_madness'
require 'minitest/autorun'

describe CryptoMadness do
  subject { CryptoMadness }

  describe "hex to base64" do
    let(:hex) { "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d" }

    describe "#to_ascii" do
      it "converts hex to ascii" do
        expected_ascii = "I'm killing your brain like a poisonous mushroom"
        subject.to_ascii(hex).must_equal expected_ascii
      end
    end

    describe "#to_base64" do
      it "converts hex to base64" do
        expected_base64 = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"
        subject.to_base64(hex).must_equal expected_base64
      end
    end
  end


  describe "#fixed_xor" do
    it "takes two equal-length buffers and produces their XOR combination" do
      buffer1 = "1c0111001f010100061a024b53535009181c"
      buffer2 = "686974207468652062756c6c277320657965"
    end
  end
end

