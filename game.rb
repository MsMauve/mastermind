class Game
  def initialize
    @board = Board.new_amount
    @player = Player.new("Player 1")
    @board.create_secret_code
  end

  def play
    puts "Welcome to MASTERMIND!"
    puts "You have 12 turns to guess the code."

    until @board.game_over?
      @board.displayguess = @player.make_guess(@board.class::COLORS)
      @board.add_guess(guess)
    end

    @board.display
    @board.reveal_code

    case @board.status
    when :won
      puts "Well done; we'll lick Fritz for sure now!"
    when :lose
      puts "I mean, it's called Enigma for a reason..."
    end
  end
end
