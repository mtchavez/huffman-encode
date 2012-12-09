require 'spec_helper'

describe Huffman do

  let(:text)        { 'aaa,bbb,ccc,d,e,f,g' }
  let(:occurrences) { Huffman.occurrences(text) }

  describe '::Node' do

    it 'initialize' do
      node = Huffman::Node.new
      node.value.must_be_nil
      node.left.must_be_nil
      node.left.must_be_nil
    end

    it 'with value' do
      node = Huffman::Node.new 30
      node.value.must_equal 30
      node.left.must_be_nil
      node.left.must_be_nil
    end

    it 'knows if it is a leaf' do
      node = Huffman::Node.new
      node.leaf?.must_equal true
    end

  end

  describe 'occurrences' do

    it 'returns array' do
      occurrences.must_be_instance_of Array
    end

    it 'has a value per character' do
      occurrences.size.must_equal 8
    end

    it 'knows total for each character' do
      occurrences.must_equal [[1, 'd'], [1, 'e'], [1, 'f'], [1, 'g'], [3, 'a'], [3, 'b'], [3, 'c'], [6, ',']]
    end

  end

  describe 'encode' do

    it 'returns nil if no characters counted' do
      Huffman.encode('').must_equal nil
    end

    it 'returns node' do
      Huffman.encode(text).must_be_instance_of Huffman::Node
    end

  end

end
