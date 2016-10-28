class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  def initialize
    @head = nil
    @tail = nil
  end

  include Enumerable

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @tail
  end

  def empty?
    @head.nil? && @tail.nil?
  end

  def get(key)
    each do |link|
      return link.val if link.key == key
    end
    nil
  end

  def include?(key)
    each do |link|
      return true if link.key == key
    end
    false
  end


  def insert(key, val)
    link = Link.new(key, val)

    link.prev = last
    last.next = link unless last.nil?

    @head = link if first.nil?

    @tail = link

    link
  end

  def remove(key)
    each do |link|
      if link.key == key
        link.prev.next = link.next unless link.prev.nil?
        link.next.prev = link.prev unless link.next.nil?

        link.next.nil? ? @head = nil : @head = link.next if @head == link
        link.prev.nil? ? @tail = nil : @tail = link.prev if @tail == link
      end
    end
  end

  def each
    link = @head
    while link != nil
      yield link
      link = link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
