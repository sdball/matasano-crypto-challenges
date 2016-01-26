#!/usr/bin/env ruby
#
class HexString
  def initialize(string)
    @ascii_hex = string
  end

  def to_ascii
    ascii_pairs.map { |pair| pair.hex.chr }.join
  end

  def to_base64
    [to_ascii].pack("m0")
  end

  private

  def ascii_hex
    @ascii_hex
  end

  def ascii_pairs
    ascii_hex.scan(/../)
  end
end
