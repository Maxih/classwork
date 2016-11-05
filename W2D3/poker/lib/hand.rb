class Hand
  attr_accessor :cards

  # COMBOS = {
  #   :one_pair = 15,
  #   :two_pair = 30,
  #   :triples = 45,
  #   :straight = 60,
  #   :flush = 75,
  #   :full_house = 90,
  #   :quads = 105,
  #   :straight_flush = 120
  #
  # }

  def initialize
    @cards = []
  end

  def add_card(card)
    @cards << card
  end

  def discard_card(card)
    @cards = @cards - [card]
  end

  def render_cards
    faces = @cards.map {|card| card.face_value }

    faces.join(", ")
  end

  def card_from_face_value(value)
    @cards.find do |card|
      card.face_value == value
    end
  end

  def full?
    @cards.length == 5
  end

  def num_pairs
    dups = Hash.new(0)
    @cards.each do |card|
      dups[card.value] += 1
    end

    dups.values.count { |num| num == 2 }
  end

  def has_triples?
    dups = Hash.new(0)
    @cards.each do |card|
      dups[card.value] += 1
    end

    dups.values.any? { |num| num == 3 }
  end

  def straight?
    num = []
    @cards.each do |card|
      num << card.value
    end

    i = num.first - 1
    num.sort!

    num.all? do |j|
      i += 1
      i == j
    end
  end

  def flush?
    suits = Hash.new(0)
    @cards.each do |card|
      suits[card.suit] += 1
    end

    suits.values.any? { |num| num == 5 }
  end

  def full_house?
    has_triples? && num_pairs == 1
  end

  def four_of_kind?
    dups = Hash.new(0)
    @cards.each do |card|
      dups[card.value] += 1
    end

    dups.values.any? { |num| num == 4 }
  end

  def straight_flush?
    straight? && flush?
  end
end
