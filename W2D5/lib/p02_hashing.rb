class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    h = 1
    self.each_with_index do |el, idx|
      # h = (el + idx) ^ h
      h = el.to_s.ord ^ h + idx
    end
    h
  end
end

class String
  def hash
    string = self.split("")
    string.map! { |el| el.ord }

    string.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    (self.keys.sort.to_s + self.values.sort.to_s).hash
  end
end
