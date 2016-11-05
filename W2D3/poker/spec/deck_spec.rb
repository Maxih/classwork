require 'deck'
require 'rspec'


describe Deck do

  subject(:deck) { Deck.new }

  describe "#initialize" do
    it "initializes a deck of cards" do
      expect(deck.cards.length).to eq(52)
    end

    it "creates 13 spades cards" do
      expect(deck.cards.count { |card| card.suit == :spades }).to eq(13)
    end

    it "creates 13 hearts cards" do
      expect(deck.cards.count { |card| card.suit == :hearts }).to eq(13)
    end

    it "creates 13 diamonds cards" do
      expect(deck.cards.count { |card| card.suit == :diamonds }).to eq(13)
    end

    it "creates 13 clubs cards" do
      expect(deck.cards.count { |card| card.suit == :clubs }).to eq(13)
    end

    it "creates 4 of each card type" do
      types = Hash.new(0)
      deck.cards.each { |card| types[card.value] += 1 }

      four_of_each = types.values.all? {|num| num == 4 }

      expect(four_of_each).to eq(true)
    end
  end

  describe "#shuffle_deck!" do
    let(:new_deck) { Deck.new }

    it "shuffles the deck" do
      deck.shuffle_deck!
      expect(deck.cards).to_not eq(new_deck.cards)
    end
  end

  describe "#deal_card" do

    it "returns the top card off the deck" do
      card = deck.cards.last
      expect(deck.deal_card).to eq(card)
    end

    it "removes the card from the deck" do
      card = deck.deal_card
      expect(deck.cards.include?(card)).to eq(false)
    end
  end
end
