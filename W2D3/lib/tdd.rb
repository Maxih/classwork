class Array
  def my_uniq
    uniques = []
    self.each do |val|
      uniques << val unless uniques.include? val
    end
    uniques
  end

  def two_sum
    sums = []

    self.each_with_index do |val, idx|
      (idx+1).upto(length-1) do |idx2|
        sums << [idx, idx2] if val + self[idx2] == 0
      end
    end
    sums
  end

  def my_transpose
    transposed = Array.new(3) { Array.new(3) }

    self.each_with_index do |val, idx|
      val.each_with_index do |val2, idx2|
        transposed[idx2][idx] = val2
      end
    end
    transposed
  end

  def stock_picker
    biggest_gain_days = []
    self.each_with_index do |val, idx|
      (idx+1).upto(length-1) do |idx2|
        biggest_gain_days = [idx, idx2] if calculate_gain([idx, idx2]) > calculate_gain(biggest_gain_days)
      end
    end
    biggest_gain_days
  end

  def calculate_gain(days)
    return 0 if days.empty?
    self[days.last] - self[days.first] 
  end
end
