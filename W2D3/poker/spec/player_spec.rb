require 'player'
require 'rspec'


describe Player do

  subject(:player) { Player.new("Max", 100) }

  let(:card) { double("card", :value=>:king, :suit=>:spades) }

  describe "#initialize" do
    it "initializes a name" do
      expect(player.name).to eq("Max")
    end

    it "initializes a pot" do
      expect(player.pot).to eq(100)
    end

    it "initializes a hand" do
      expect(player.hand.class).to be(Hand)
    end
  end

  describe "#discard_card" do
    it "removes a card from the hand" do
      player.hand.add_card(card)
      expect(player.hand.cards.include?(card)).to eq(true)

      player.discard_card(card)
      expect(player.hand.cards.include?(card)).to eq(false)
    end
  end

  describe "#raise_pot" do
    it "removes the amount from the users pot" do
      player.raise_pot(10)
      expect(player.pot).to eq(90)
    end

    it "does not go below 0" do
      player.raise_pot(101)
      expect(player.pot).to eq(100)
    end
  end
end
