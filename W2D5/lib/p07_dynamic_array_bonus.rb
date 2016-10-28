class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  attr_reader :count

  include Enumerable

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    i = @count + i if i < 0
    @store[i] if i.between?(0, capacity-1)
  end

  def []=(i, val)
    i = @count + i if i < 0

    @store[i] = val if i.between?(0, capacity-1)
  end

  def capacity
    @store.length
  end

  def include?(val)

    @count.times do |idx|
      return true if @store[idx] == val
    end
    false
  end

  def push(val)
    resize! if @count + 1 == capacity

    @store[@count] = val
    @count += 1
  end

  def unshift(val)
    # resize! if @count + 1 == capacity
    new_arr = StaticArray.new(capacity)

    new_arr[0] = val
    @count.times do |idx|
      new_arr[idx+1] = @store[idx] if idx+1 < capacity
    end

    @count += 1
    @store = new_arr


  end

  def pop
    return nil if @count == 0

    val = @store[@count-1]
    @store[@count-1] = nil

    @count -= 1

    val
  end

  def shift

    new_arr = StaticArray.new(capacity)

    val = first
    return val if val.nil?

    i = 0
    until @store[i].nil?
      new_arr[i] = @store[i + 1]
      i += 1
    end

    @count -= 1

    @store = new_arr
    val
  end

  def first
    @store[0]
  end

  def last
    capacity.times do |idx|
      return @store[idx - 1] if @store[idx] == nil && idx != 0
      return nil if idx == capacity - 1
    end

  end

  def each
    @count.times do |idx|
      yield(@store[idx])
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)

    other.each_with_index do |val, idx|
      return false if @store[idx] != val
    end
    # ...

    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_arr = StaticArray.new(capacity*2)

    i = 0
    until @store[i].nil?
      new_arr[i] = @store[i]
      i += 1
    end



    @store = new_arr
  end
end
