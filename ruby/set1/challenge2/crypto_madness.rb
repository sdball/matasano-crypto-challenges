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
end
