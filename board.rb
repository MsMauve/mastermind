require 'colorize'

class Board
  COLORS = [:red, :blue, :green, :magenta]
  CODE_LENGTH = 4

  
  def initialize
    @secret_code = Array.new(CODE_LENGTH)
    @guesses = []
    @feedback = []
  end

  def create_secret_code
    @secret_code = CODE_LENGTH.times.map { COLORS.sample }
    system('clear')
    puts "Code set: starting game!"
  end

  def set_code(code)
    if valid_code?(code)
      @secret_code = code
      system('clear')
      puts "Code accepted: starting game!"
      true
    else
      puts "Invalid code! Must be #{CODE_LENGTH} available colors: #{COLORS.join(', ')}"
    end
  end

  def add_guess(guess)
    if valid_code?(guess)
      @guesses.append(guess)
      @feedback.append(generate_feedback(guess))
      true
    else
      puts "Invalid guess! Use #{CODE_LENGTH} valid colors: #{COLORS.join(', ')}"
      false
    end
  end

  def display
    puts "=== MASTERMIND ===".center(20)
    puts "-" * 20

    @guesses.each_with_index do |guess, i|
      print "#{i + 1}.".ljust(3)
      guess.each do |color|
        print "⬤".colorize(color)
      end
   
      print " | "

      @feedback[i].each do |peg|
        print "●".colorize(peg)
      end
      puts
    end

    (12 - @guesses.length).times do |i|
      print "#{@guesses.length + i + 1}".ljust(3)
      CODE_LENGTH.times { print "○ "}
      puts
    end

    puts "-" * 20
    puts "Colors: #{COLORS.map { |c| "⬤".colorize(c) }.join(" ")}"
  end

  def game_over?
    won? || lost?
  end

  def status
    if won?
      :won
    elsif lost?
      :lost
    else
      :playing
    end
  end

  def reveal_code
    if game_over?
      print "Secret code was: "
      @secret_code.each { |color| print "⬤ ".colorize(color) }
      puts
    else
      puts "The game's not over yet, silly!"
    end
  end



  private

  def won?
    return false if @guesses.empty?
    @feedback.last == Array.new(CODE_LENGTH, :black)
  end

  def lost?
    @guesses.length >= 12
  end

  def valid_code?(code)
    code.length == CODE_LENGTH && code.all? { |color| COLORS.include?(color) }
  end

  def generate_feedback(guess)
    color_and_location_matches = 0
    color_matches = 0
    secret_code_copy = @secret_code.dup
    guess_copy = guess.dup

    guess.each_with_index do |color, i|
      if color == @secret_code[i]
        color_and_location_matches += 1
        secret_code_copy[i] = nil
        guess_copy[i] = nil
      end
    end

    guess_copy.each do |color|
      next if color.nil?
      if secret_code_copy.include?(color)
        color_matches += 1
        secret_code_copy[secret_code_copy.index(color)] = nil
      end
    end

    Array.new(color_and_location_matches, :black) + Array.new(color_matches, :white)
  end
end

