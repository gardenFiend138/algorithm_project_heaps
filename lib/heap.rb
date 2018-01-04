class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    prc ||= Proc.new { |x, y| x <=> y }
    
    @store = Array.new
    
    @store.each_with_index do |int, idx| 
      prc.call(int, @store[idx + 1]) if idx < count
    end 
    
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
  
  # come back to handling the proc
  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    
    heaped = false 
    until heaped 
      heaped = true
      child_idxs = self.child_indices(len, parent_idx)
      
      unless child_idxs.length < 2
        smallest_child_idx = (child_idxs[0] < child_idxs[1]) ? child_idxs[0] : child_idxs[1]
        parent = array[parent_idx]
      end
      
      # if parent > array[smallest_child_idx] 
      if prc.call(parent_idx, smallest_child_idx) == -1
        self.swap(array, parent_idx, smallest_child_idx)
        parent_idx = smallest_child_idx

        heaped = false
      end 
    end

    array
  end
  
  # come back to handling the proc  
  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    
    heaped = false 
    until heaped 
      heaped = true
      
      child_idx > 0 ? parent_idx = self.parent_index(child_idx) : nil
      
      # if prc.call(parent_idx, child_idx) == -1
      if parent_idx && array[parent_idx] > array[child_idx]
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
  
end

# puts BinaryMinHeap.heapify_up([5,7,6], 2)