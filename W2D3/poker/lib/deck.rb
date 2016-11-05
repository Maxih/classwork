require_relative "card"

class Deck
  CARDS = {
    2 => "2",
    3 => "3",
    4 => "4",
    5 => "5",
    6 => "6",
    7 => "7",
    8 => "8",
    9 => "9",
    10 => "10",
    11 => "Jack",
    12 => "Queen",
    13 => "King",
    14 => "A",
  }

  SUITS = {
    :spades => "spades",
    :hearts => "hearts",
    :clubs => "clubs",
    :diamonds => "diamonds"
  }

  attr_accessor :cards

  def initialize
    @cards = []
    fill_deck
  end

  def fill_deck
    SUITS.keys.each do |suit|
      CARDS.keys.each do |card|
        @cards << Card.new(card, suit, CARDS[card])
      end
    end
  end

  def shuffle_deck!
    @cards.shuffle!
  end

  def deal_card
    @cards.pop
  end
end
