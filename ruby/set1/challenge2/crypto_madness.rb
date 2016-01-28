#!/usr/bin/env ruby
#
class CryptoMadness
  def self.to_ascii(hex)
    ascii_pairs(hex).map { |pair| pair.hex.chr }.join
  end

  def self.to_base64(hex)
    [to_ascii(hex)].pack("m0")
  end

  def self.ascii_pairs(hex)
    hex.scan(/../)
  end
end
