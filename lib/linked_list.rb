class LinkedList
  attr_accessor :head, :size

  def initialize(head=nil)
    raise ArgumentError, "head must be a Node" unless head.nil? || head.is_a?(Node)
    @head = head
    @size = 0
  end

  def append(value)
    @size += 1
    new_node = Node.new(value)
    if @head.nil?
      @head = new_node
    else
      current = @head
      current = current.next_node while current.next_node
      current.next_node = new_node
    end
  end

  def prepend(value)
    @size += 1
    @head = Node.new(value, @head)
  end

  def tail
    current = @head
    return current if current.nil? # If the head is nil (unitialized), return nil
    current = current.next_node until current.next_node.nil?
    current
  end

  def at(desired_index)
    current_node = @head
    abort("Error: Empty list") if current_node.nil?
    abort("Error: Index out of bounds") if desired_index > (self.size - 1)

    current_index = 0
    until current_index == desired_index
      current_index += 1
      current_node = current_node.next_node
    end
    current_node.value
  end

  def pop
    @size -= 1
    return if @head == nil
    current_node = @head
    last_node = nil 
    until current_node.next_node.nil?
      current_node, last_node = current_node.next_node, current_node
    end
    last_node.next_node = nil
    self
  end

  def contains?(value)
    current_node = @head
    until current_node.nil?
      return true if current_node.value == value
      current_node = current_node.next_node
    end
    false
  end

  def find(value)
    index = 0
    current_node = @head
    until current_node.nil?
      return index if current_node.value == value
      current_node = current_node.next_node
      index += 1
    end
    nil
  end

  def to_s
    output = ""
    return nil if @head.nil?

    current_node = @head
    until current_node.nil?
      output += "( #{current_node.value} ) -> "
      current_node = current_node.next_node
    end
    output += "nil"
  end

  def to_array
    output = []
    return if @head.nil?

    current_node = @head
    until current_node.nil?
      output << current_node.value
      current_node = current_node.next_node
    end
    output
  end
end

class Node
  attr_accessor :value, :next_node

  def initialize(value, next_node=nil)
    @value = value
    @next_node = next_node
  end
end

list = LinkedList.new

list.append('dog')
list.append('cat')
list.append('parrot')
list.append('hamster')
list.append('snake')
list.append('turtle')

p list.to_array