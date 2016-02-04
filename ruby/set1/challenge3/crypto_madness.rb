#!/usr/bin/env ruby

module CryptoMadness
  class HexString
    attr_reader :raw

    def initialize(string)
      @raw = string
    end

    def to_ascii
      to_hex.map { |hex| hex.chr }.join
    end

    def to_hex
      ascii_pairs.map { |pair| pair.hex }
    end

    def to_base64
      [to_ascii].pack("m0")
    end

    def ascii_pairs
      raw.scan(/../)
    end
  end

  def self.fixed_xor(buffer1, buffer2)
    (buffer1.hex ^ buffer2.hex).to_s(16)
  end

  def self.decipher_single_byte_xor(hex_encoded_string)
    deciphered_strings = 0.upto(255).map { |n|
      ascii = HexString.new(hex_encoded_string).to_ascii
      xor_string(ascii, n)
    }
    most_likely_ascii(deciphered_strings)
  end

  def self.xor_string(string, key)
    string.each_byte.map { |byte| (byte ^ key).chr }.join
  end

  def self.most_likely_ascii(strings)
    scored = strings.map { |s| [s, ascii_score(s)] }
    scored.max { |a,b| a[1] <=> b[1] }.first
  end

  def self.ascii_score(potential_string)
    potential_string.scan(/[a-zA-Z0-9 ]/).size
  end
end
