require 'tdd'
require 'rspec'


describe Array do

  describe "#my_uniq" do
    let(:array1) { [1, 2, 3, 2, 5, -1, 5] }
    let(:array2) { [6, 2, 7, 1, 2, 6, 8] }

    it "filters duplicate values" do
      expect(array1.my_uniq).to eq([1, 2, 3, 5, -1])
      expect(array2.my_uniq).to eq([6, 2, 7, 1, 8])
    end

    it "does not modify the original array" do
      expect(array1.my_uniq).to_not eq(array1)
    end
  end

  describe "#two_sum" do
    it "returns index's that sum to 0" do
      expect([1, 2, -5, 2, 5, -1, 5].two_sum).to eq([[0, 5], [2, 4], [2, 6]])
    end

    it "returns an empty array if there are no pairs" do
      expect([0, 1, 2, 3].two_sum).to eq([])
    end
  end

  describe "#my_transpose" do
    let(:transpose1) { [[0, 1, 2], [3, 4, 5], [6, 7, 8]] }
    let(:transpose2) { [[8, 7, 6], [5, 4, 3], [2, 1, 0]] }

    it "transposes the array" do
      expect(transpose1.my_transpose).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
      expect(transpose2.my_transpose).to eq([[8, 5, 2], [7, 4, 1], [6, 3, 0]])
    end

    it "does not modify the original array" do
      expect(transpose1.my_transpose).to_not eq(transpose1)
    end
  end

  describe "#stock_picker" do
    it "picks the most profitable stocks" do
      expect([1000, 900, 800, 700, 200, 400, 500, 2000, 100, 1000].stock_picker).to eq([4,7])
    end

    it "returns empty if all stocks result in a loss" do
      expect([1000, 900, 800, 200, 100].stock_picker).to eq([])
    end
  end
end
