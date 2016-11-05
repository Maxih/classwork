require 'towers_of_hanoi'
require 'rspec'


describe TowersOfHanoi do

  subject(:hanoi) { TowersOfHanoi.new }

  describe "#initialize" do
    it "creates a board" do
      expect(hanoi.board).to_not eq(nil)
    end

    it "populates the board" do
      expect(hanoi.board.first).to eq([3, 2, 1])
    end
  end

  # describe "#prompt_user" do
  #   it "returns a valid move" do
  #     expect(hanoi.prompt_user).to be_a(Array)
  #     expect(hanoi.prompt_user.length).to be(2)
  #   end
  # end

  describe "#move" do
    before(:each) do
      hanoi.move(0, 1)
      hanoi.move(0, 2)
    end

    it "moves a piece" do
      expect(hanoi.board.first).to eq([3])
      expect(hanoi.board[1]).to eq([1])
      expect(hanoi.board.last).to eq([2])
    end

    it "does not move a piece on top of a bigger piece" do
      hanoi.move(0, 2)
      expect(hanoi.board.first).to eq([3])
      expect(hanoi.board.last).to eq([2])
    end

    it "does not move a piece to an invalid position" do
      hanoi.move(0, 5)
      expect(hanoi.board.first).to eq([3])
      expect(hanoi.board[1]).to eq([1])
      expect(hanoi.board.last).to eq([2])
    end
  end

  describe "#won?" do
    before(:each) do
      hanoi.move(0, 2)
      hanoi.move(0, 1)
      hanoi.move(2, 1)
      hanoi.move(0, 2)
      hanoi.move(1, 0)
      hanoi.move(1, 2)
      # hanoi.move(0, 2) winning move
    end

    it "is false when the game is not over" do
      expect(hanoi.won?).to eq(false)
    end

    it "is true when the game is won" do
      hanoi.move(0, 2)
      expect(hanoi.won?).to eq(true)
    end
  end
end
