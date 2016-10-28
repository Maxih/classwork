require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count

  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[key.hash % num_buckets].include?(key)
  end

  def set(key, val)
    @count += 1
    insert(key, val)
  end

  def get(key)
    @store[key.hash % num_buckets].get(key)
  end

  def delete(key)
    @count -= 1 if include?(key)
    @store[key.hash % num_buckets].remove(key)
  end

  def each
    @store.each do |bucket|
      bucket.each do |link|
        yield(link.key, link.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def insert(key, val)
    idx = key.hash % num_buckets
    @store[idx].remove(key) if @store[idx].include?(key)
    @store[idx].insert(key, val)

    resize! if @count > num_buckets
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = @store.flatten
    @store = Array.new(num_buckets * 2) { LinkedList.new }

    new_store.each do |el|
      el.each do |link|
        insert(link.key, link.val)
      end
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
