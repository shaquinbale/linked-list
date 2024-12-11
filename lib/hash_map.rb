class Hashmap
  attr_reader :size, :capacity, :load_factor

  def initialize(load_factor=0.75, capacity=16)
    @load_factor = load_factor
    @capacity = capacity
    @size = 0
    @buckets = Array.new(@capacity)
  end

  # DJB2 Hash Function
  def hash(string)
    hash_key = 5381 # The "Magic Number" according to google

    string.chars.each do |char|
      hash_key = ((hash_key << 5) + hash_key) + char.ord # (x << 5) + x is the same as x * 33
    end

    hash_key
  end

  def []=(key, value)
    index = hash(key) % @capacity
  
    bucket = @buckets[index]
    
    if bucket.nil?
      @size += 1
      @buckets[index] = [[key, value]]
    else
      existing_item = bucket.find { |item| item[0] == key }
      
      if existing_item
        existing_item[1] = value
      else
        bucket << [key, value]
      end
    end

    resize if @size > (@capacity * @load_factor)
  end

  def [](key)
    bucket = @buckets[hash(key) % @capacity]
    return nil if bucket.nil?

    bucket.each { |item| return item[1] if item[0] == key }

    nil
  end

  def has?(key)
    !!self[key]
  end

  def remove(key)
    bucket = @buckets[hash(key) % @capacity]
    item = bucket.find {|item| item[0] == key}
    
    if item
      @size -= 1
      bucket.delete item
      return item
    else
      raise KeyError, "Key not found"
    end
  end

  def length
    return 0 if @buckets.nil?
    length = 0
    @buckets.each do |bucket|
      next if bucket.nil?
      bucket.each do |item|
        length += 1
      end
    end
    length
  end

  def clear
    @buckets = Array.new(@capacity)
    @size = 0
  end

  def keys
    return nil if @buckets.nil?
    @buckets.compact.map { |bucket| bucket[0]}
  end

  def values
    return nil if @buckets.nil?
    @buckets.compact.map { |bucket| bucket[1]}
  end

  def entries
    @buckets.compact
  end

  def resize
    old_buckets = @buckets
    @capacity *= 2
    @capacity
    @buckets = Array.new(@capacity)
    @size = 0

    old_buckets.each do |bucket|
      next unless bucket

      bucket.each do |item|
        self[item[0]] = item[1]
      end
    end
  end
end
