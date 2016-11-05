class TowersOfHanoi
  attr_reader :board

  def initialize
    @board = Array.new(3) { [] }

    populate_board
  end

  def play
    until won?
      render
      coords = prompt_user
      move(coords.first, coords.last)
    end

    puts "you win!!"
  end

  def render
    system('clear')
    @board.each_with_index do |val, idx|
      puts "#{idx}: #{val.join(',')}"
    end
  end

  def populate_board
    @board[0] = [3, 2, 1]
  end

  def prompt_user
    puts "enter coords"
    gets.chomp.split(",").map { |el| el.to_i }
  end

  def move(start_pos, end_pos)
    @board[end_pos] << @board[start_pos].pop if valid_move?(start_pos, end_pos)
  end

  def valid_move?(start_pos, end_pos)
    return false if @board[start_pos].nil? || @board[end_pos].nil?
    
    first_piece = @board[start_pos].first
    end_piece = @board[end_pos].first

    return false if first_piece.nil?
    return false if !end_piece.nil? && first_piece > end_piece

    true
  end

  def won?
    @board[0].empty? && @board[1].empty?
  end
end

if __FILE__ == $PROGRAM_NAME
  t = TowersOfHanoi.new
  t.play
end
