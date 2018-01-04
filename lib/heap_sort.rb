require_relative "heap"

class Array
  def heap_sort!
    heap_partition = 0
     
    while heap_partition < self.length
      BinaryMinHeap.heapify_down(self[heap_partition..self.length], heap_partition)
      heap_partition += 1 
    end 
    
    self
  end
end
