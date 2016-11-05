require_relative 'deck'
require_relative 'player'

class Poker

  def initialize
    @deck = nil
    @players = [
      Player.new("Max", 100),
      Player.new("Zack", 100),
      Player.new("Rob", 100),
      Player.new("Christian", 100)
    ]
  end

  def play

    until game_over?
      puts "Dealing a new hand"
      sleep(2)

      new_turn

      play_turn

      end_turn
    end
  end

  def play_turn
    while round_live?
      @players.each do |player|
        player.play_turn

        until player.hand.full?
          player.recieve_card(@deck.deal_card)
        end

        return unless round_live?

        sleep(2)
      end

    end
  end

  def end_turn
    @players.each do |player|
      player.setup_new_round
    end
  end

  def round_live?
    @players.count do |player|
      !player.fold
    end > 1
  end

  def game_over?
    @players.count do |player|
      player.pot > 0
    end == 1
  end

  def new_turn
    @deck = Deck.new
    @deck.shuffle_deck!

    5.times do
      @players.each do |player|
        player.recieve_card(@deck.deal_card)
      end
    end
  end
end

game = Poker.new

p game.play
