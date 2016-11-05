require 'card'
require 'rspec'


describe Card do

  describe "#initialize" do
    subject(:card) { Card.new(13, :spades, "King") }
    it "initializes to a face value" do
      expect(card.value).to eq(13)
    end

    it "initializes to a suit" do
      expect(card.suit).to eq(:spades)
    end
  end
end
