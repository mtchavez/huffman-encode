require 'rubygems'
require 'fileutils'
require File.join(FileUtils.pwd, 'lib/huffman.rb')

html   = File.read(File.join(FileUtils.pwd, 'sample.html'))
tree   = Huffman.encode(html)
bitsum = 0
bits   = []

for char in html.scan(/./m)
  char_bits = Huffman.bits(tree, char)
  bitsum += char_bits.length
  bits << char_bits
end

orig    = html.length
encoded = bitsum / 8.0

printf("original %s bytes, huffman encoded: %s bytes, ratio: %.2f%%\n", orig, encoded, encoded / orig * 100)

# p ht_marshal.length
# p encoded
# decoded = ''
# bits.each{|bit| decoded << Huffman.decode(Marshal.load(ht_marshal), bit)}
# p decoded
