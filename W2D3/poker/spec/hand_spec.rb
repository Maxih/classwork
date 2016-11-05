require 'hand'
require 'rspec'


describe Hand do

  subject(:hand) { Hand.new }
  let(:card) { double("card", :value=>13, :suit=>:spades) }
  let(:ace_of_spades) { double("ace_of_spades", :value=>14, :suit=>:spades) }
  let(:ace_of_clubs) { double("ace_of_clubs", :value=>14, :suit=>:clubs) }
  let(:ace_of_diamonds) { double("ace_of_diamonds", :value=>14, :suit=>:diamonds) }
  let(:ace_of_hearts) { double("ace_of_hearts", :value=>14, :suit=>:hearts) }
  let(:two_of_diamonds) { double("two_of_diamonds", :value=>2, :suit=>:diamonds) }
  let(:two_of_spades) { double("two_of_spades", :value=>2, :suit=>:spades) }
  let(:three_of_clubs) { double("three_of_clubs", :value=>3, :suit=>:clubs) }
  let(:four_of_spades) { double("four_of_spades", :value=>4, :suit=>:spades) }
  let(:five_of_diamonds) { double("five_of_diamonds", :value=>5, :suit=>:diamonds) }
  let(:six_of_clubs) { double("six_of_clubs", :value=>6, :suit=>:clubs) }
  let(:ten_of_clubs) { double("ten_of_clubs", :value=>10, :suit=>:diamonds) }
  let(:eight_of_spades) { double("eight_of_spades", :value=>8, :suit=>:spades) }
  let(:king_of_spades) { double("king_of_spades", :value=>8, :suit=>:spades) }
  let(:three_of_spades) { double("three_of_spades", :value=>3, :suit=>:spades) }
  let(:five_of_spades) { double("five_of_spades", :value=>5, :suit=>:spades) }
  let(:six_of_spades) { double("six_of_spades", :value=>6, :suit=>:spades) }

  describe "#initialize" do
    it "initializes a hand" do
      expect(hand.cards).to eq([])
    end
  end

  describe "#add_card" do
    it "adds a card to the hand" do
      hand.add_card(card)
      expect(hand.cards).to eq([card])
    end
  end

  describe "#discard_card" do
    it "removes a card from the hand" do
      hand.add_card(card)
      hand.discard_card(card)
      expect(hand.cards).to eq([])
    end
  end

  describe "#num_pairs" do
    it "detects a single pair" do
      hand.add_card(ace_of_spades)
      hand.add_card(ace_of_clubs)
      hand.add_card(two_of_diamonds)
      hand.add_card(five_of_diamonds)
      hand.add_card(ten_of_clubs)

      expect(hand.num_pairs).to eq(1)
    end

    it "detects two pairs" do
      hand.add_card(ace_of_spades)
      hand.add_card(ace_of_clubs)
      hand.add_card(two_of_diamonds)
      hand.add_card(two_of_spades)
      hand.add_card(ten_of_clubs)

      expect(hand.num_pairs).to eq(2)
    end
  end

  describe "#has_triples?" do
    it "detects three of the same" do
      hand.add_card(ace_of_spades)
      hand.add_card(ace_of_clubs)
      hand.add_card(ace_of_diamonds)
      hand.add_card(two_of_spades)
      hand.add_card(ten_of_clubs)

      expect(hand.has_triples?).to eq(true)
    end
  end

  describe "#straight?" do
    it "detects a straight" do
      hand.add_card(two_of_spades)
      hand.add_card(three_of_clubs)
      hand.add_card(four_of_spades)
      hand.add_card(five_of_diamonds)
      hand.add_card(six_of_clubs)

      expect(hand.straight?).to eq(true)
    end
  end

  describe "#flush?" do
    it "detects a flush" do
      hand.add_card(two_of_spades)
      hand.add_card(eight_of_spades)
      hand.add_card(four_of_spades)
      hand.add_card(ace_of_spades)
      hand.add_card(king_of_spades)

      expect(hand.flush?).to eq(true)
    end
  end

  describe "#full_house?" do
    it "detects a full house" do
      hand.add_card(ace_of_spades)
      hand.add_card(ace_of_clubs)
      hand.add_card(ace_of_diamonds)
      hand.add_card(two_of_diamonds)
      hand.add_card(two_of_spades)

      expect(hand.full_house?).to eq(true)
    end
  end

  describe "#four_of_kind?" do
    it "detects 4 of a kind" do
      hand.add_card(ace_of_spades)
      hand.add_card(ace_of_clubs)
      hand.add_card(ace_of_diamonds)
      hand.add_card(ace_of_hearts)
      hand.add_card(two_of_spades)

      expect(hand.four_of_kind?).to eq(true)
    end
  end

  describe "#straight_flush?" do
    it "detects a straight flush" do
      hand.add_card(two_of_spades)
      hand.add_card(three_of_spades)
      hand.add_card(four_of_spades)
      hand.add_card(five_of_spades)
      hand.add_card(six_of_spades)

      expect(hand.straight_flush?).to eq(true)
    end
  end
end
