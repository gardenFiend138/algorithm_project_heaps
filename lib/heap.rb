class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    prc ||= Proc.new { |x, y| x <=> y }
    
    @store = Array.new
    
    @store.each_with_index do |int, idx| 
      prc.call(int, @store[idx + 1])
    end 
    
    @store
  end

  def count
    @store.count
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    parent = @store.pop 
    
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
  end

  public
  def self.child_indices(len, parent_index)
    @child_indices = []
    first_child_idx = parent_index * 2 + 1
    second_child_idx = parent_index * 2 + 2
    first_child_idx < len ? @child_indices << first_child_idx : nil
    second_child_idx < len ? @child_indices << second_child_idx : nil
    
    @child_indices
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0 
    (child_index - 1) / 2
  end
  
  # come back to handling the proc
  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    heaped = false 
    
    until heaped 
      heaped = true
      child_idxs = self.child_indices(len, parent_idx)
      
      unless child_idxs.empty?
        smallest_child_idx = (child_idxs[0] < child_idxs[1]) ? child_idxs[0] : child_idxs[1]
        parent = array[parent_idx]
      end
      
      if parent > array[smallest_child_idx] 
        self.swap(array, parent_idx, smallest_child_idx)
        parent_idx = smallest_child_idx

        heaped = false
      end 
    end

    array
  end
  # come back to handling the proc
  def self.heapify_up(array, child_idx, len = array.length, &prc)
    parent_idx = self.parent_index(child_idx)
  end
  
  def self.swap(array, x, y)
    array[x], array[y] = array[y], array[x] 
  end
  
end