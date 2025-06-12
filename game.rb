class Game
  def initialize
    setup_game
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

  private

  def setup_game
    @board = Board.new
    choose_role
    setup_players
  end

  def choose_role
    puts "Would you like to make the code, or try to guess it?"
    puts "1. Guesser"
    puts "2. Maker"

    loop do
      puts "Enter your choice (1 or 2): "
      choice = gets.chomp.to_i
      if [1, 2].include?(choice)
        return choice == 1? :guesser : :maker
      end
      puts "Invalid choice: 1 or 2?"
    end
  end

  def setup_players
    role = choose_role
    @player = Player.new("Player 1", role)
    if role == :maker
      code = @player.create_code(@board.class::COLORS)
      @board.set_code(code)
    else
      @board.create_secret_code
    end
  end

  def computer_guess
    Array.new(4) { @board.class::COLORS.sample }
  end
end
