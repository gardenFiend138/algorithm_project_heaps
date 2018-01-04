class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    unless prc 
      prc = Proc.new { |x, y| x <=> y }
    end
    
    @store = Array.new
    
    # @store.each_with_index do |int, idx| 
    #   prc.call(int, @store[idx + 1]) if idx < count
    # end 
    
    @store
  end

  def count
    @store.length
  end

  def extract
    self.class.swap(@store, 0, -1)
    child_idx = count - 1
    extracted = @store.pop 
    self.class.heapify_down(@store, 0)
    extracted
  end

  # returns the 'highest priority item' without removing it
  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    child_idx = count - 1
    self.class.heapify_up(@store, child_idx)
  end

  public
  def self.child_indices(len, parent_index)
    @child_indices = []
    first_child_idx = parent_index * 2 + 1
    second_child_idx = parent_index * 2 + 2
    
    @child_indices << first_child_idx if first_child_idx < len
    @child_indices << second_child_idx if second_child_idx < len
    
    @child_indices
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0 
    (child_index - 1) / 2
  end
  
  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }

    heaped = false 
    until heaped 
      heaped = true
      child_idxs = self.child_indices(len, parent_idx)
      parent = array[parent_idx]
      
      if child_idxs.length > 1
        child1 = array[child_idxs[0]]
        child2 = array[child_idxs[1]]
        smallest_child_idx = prc.call(child1, child2) == -1 ? child_idxs[0] : child_idxs[1]  
      elsif child_idxs.length == 1
        smallest_child_idx = child_idxs[0]
      else
        smallest_child_idx = nil
      end
      #try to abstract this out into a helper method
      # smallest_child_idx = self.find_children(child_idxs, prc)
      
      if smallest_child_idx && prc.call(parent, array[smallest_child_idx]) == 1
        self.swap(array, parent_idx, smallest_child_idx)
        parent_idx = smallest_child_idx

        heaped = false
      end 
    end

    array
  end
  
  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    
    heaped = false 
    until heaped 
      heaped = true
      
      child_idx > 0 ? parent_idx = self.parent_index(child_idx) : nil
      
      if parent_idx && child_idx && prc.call(array[parent_idx], array[child_idx]) == 1
        self.swap(array, parent_idx, child_idx)
        child_idx = parent_idx
        heaped = false 
      end 
    end 
    
    array
  end
  
  def self.swap(arr, x, y)
    arr[x], arr[y] = arr[y], arr[x] 
  end
  
  # def self.find_children(indices, &prc)
  #   prc ||= Proc.new { |x, y| x <=> y }
  # 
  #   if child_idxs.length > 1
  #     child1 = array[child_idxs[0]]
  #     child2 = array[child_idxs[1]]
  # 
  #     smallest_child_idx = prc.call(child1, child2) == -1 ? child_idxs[0] : child_idxs[1]  
  #   elsif child_idxs.length == 1
  #     smallest_child_idx = child_idxs[0]
  #   else
  #     smallest_child_idx = nil
  #   end
  #   smallest_child_idx
  # end
  
end

puts 'This is a test of the BinaryMinHeap system: '
p BinaryMinHeap.heapify_down([4,2,1,3,5,7,8,9], 0)