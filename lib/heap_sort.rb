require_relative "heap"
require 'byebug'
class Array
  def heap_sort!
    heap_partition = 0
    # puts 'starting self ----------'
    # p self
    # puts '-----------'
    while heap_partition < self.length
      # puts 'here is the array portion ---------'
      # p self[heap_partition..self.length]
      # puts '------------'
      # byebug
      p BinaryMinHeap.heapify_down(self[heap_partition...self.length], heap_partition)
      # puts 'after being heaped self ----------'
      # p self
      # puts '-----------'
      heap_partition += 1 
    end 
    p BinaryMinHeap.heapify_down(self[heap_partition...self.length], heap_partition)
    # puts 'return self------------'
    # p self
    # self
  end
end
# 
# puts 'This is a test for heap_sort! '
# p [4,2,7,1,8,3,9,0,5].heap_sort!
