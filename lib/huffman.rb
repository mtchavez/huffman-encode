class Huffman

  class Node

    attr_accessor :value, :left, :right

    def initialize(value = nil, left = nil, right = nil)
      @value, @left, @right = value, left, right
    end

    def leaf?
      @left.nil? and @right.nil?
    end

  end

  # return an ordered array of [occurrences, character] descending order
  def self.occurrences(text)
    char_counts = Hash.new(0)
    text.scan(/./m) { |char| char_counts[char] += 1 }
    char_counts.keys.map { |key| [char_counts[key], key] }.sort
  end

  def self.encode(text)
    char_counts = occurrences(text)
    message = 'warning: no occurrences provided to build huffman tree'
    warn!(message) and return if char_counts.empty?
    build_tree char_counts
  end

  def self.build_tree(char_counts)
    leaves   = char_counts.map { |entry| Node.new [entry] }
    interior = []
    de_queue = lambda { (leaves.length > 0) ? leaves.delete_at(0) : interior.delete_at(0) }

    # create interior nodes
    while leaves.length + interior.length > 1
      left  = de_queue.call
      right = de_queue.call
      node  = Node.new(left.value + right.value, left, right)
      interior << node
    end

    de_queue.call
  end

  # given a tree and character return an array of encoded bits
  def self.bits(node, char)
    message = "warning: no binary encoding for: '#{char}'"
    warn!(message) and return [] if node.value.rassoc(char).nil?

    enc, value = internal_bits(node, char, [])
    message = "warning: binary encoding: #{enc.inspect}, value: #{value.inspect} does not match '#{char}'"
    warn!(message) and return [] if value[0][1] != char
    enc
  end

  def self.internal_bits(node, char, enc)
    return [enc, nil] unless node
    return [enc, node.value] if node.leaf?

    if node.left.value.rassoc(char).nil?
      enc << 1
      internal_bits(node.right, char, enc)
    else
      enc << 0
      internal_bits(node.left, char, enc)
    end
  end

  def self.decode(node, bits)
    return node.value[0][1] if node.leaf?

    remaning = bits[1..-1]

    if bits[0].zero?
      decode(node.left, remaning)
    elsif bits[0] == 1
      decode(node.right, remaning)
    end
  end

  def self.warn! message
    p message unless ENV['environment'] == 'test'
  end

end