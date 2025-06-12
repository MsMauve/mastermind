class Game
  def initialize
    setup_game
  end

  def play
    puts "Welcome to MASTERMIND!"
    puts "You have 12 turns to guess the code."

    until @board.game_over?
      @board.display 
      guess = if @player.role == :guesser
                @player.make_guess(@board.class::COLORS)
              else
                result = computer_guess
                sleep(3)
                result
              end
      @board.add_guess(guess)
    end

    @board.display
    @board.reveal_code

    case @board.status
    when :won
      winner = @player.role == :guesser ? "You've" : "The computer has"
      puts "#{winner} cracked the code!"
    when :lost
      puts "It'll be cracked someday, surely..."
    end
  end

  private

  def setup_game
    @board = Board.new
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
    puts "Computer is thinking..."
    guess = Array.new(@board.class::CODE_LENGTH) { @board.class::COLORS.sample }
    puts "Computer guesses: #{guess.join(' ')}"
    guess
  end
end
