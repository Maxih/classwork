require_relative 'hand'

class Player
  attr_accessor :name, :pot, :hand, :fold

  def initialize(name, pot)
    @name = name
    @pot = pot
    @hand = Hand.new
    @fold = false
  end

  def discard_card(card)
    @hand.discard_card(card)
  end

  def recieve_card(card)
    @hand.add_card(card)
  end

  def render_hand
    self.hand.render_cards
  end

  def setup_new_round
    @fold = false
    @hand = Hand.new
  end

  def play_turn
    system('clear')
    puts self.render_hand

    puts "It's #{name}'s turn"

    get_turn
  end

  def get_turn
    move = gets.chomp

    case move
    when ""
      puts "Ends turn"
      return
    when "fold"
      @fold = true
      puts "#{name} Folds"
    when "check"
      puts "Checks"
    when "raise"
      puts "How much?"
      value = gets.chomp.to_i
      raise_pot(value)
      puts "#{name} raises $#{value}"
    else
      move = move.split(",").map(&:chomp)

      move.each do |card|
        discard_card(@hand.card_from_face_value(card))
      end
    end
  end

  def raise_pot(value)
    self.pot -= value if self.pot - value >= 0
  end

end
