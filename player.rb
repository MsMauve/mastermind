class Player
  attr_reader :name, :role

  def initialize(name, role = :guesser)
    @name = name
    @role = role
  end

  def make_guess(available_colors)
    puts "#{@name}'s turn"
    puts "Available colors: #{available_colors.join(', ')}"
    loop do
      print "Enter four colors (separated with a space): "
      input = gets.chomp.downcase.split

      if valid_guess?(input, available_colors)
        return input.map(&:to_sym)
      else
        puts "Sorry, you gotta enter 4 colors that are valid!"
      end
    end
  end

  def create_code(available_colors)
    puts "#{@name}, create your secret code now!"
    puts "Available colors: #{available_colors.join(', ')}"

    loop do
      print "Enter 4 colors (separated with a space): "
      guess = gets.chomp.downcase.split

      if valid_guess?(guess, available_colors)
        return guess.map(&:to_sym)
      else
        puts "Nice try! Enter a valid code, please."
      end
    end
  end

  private

  def valid_guess?(input, available_colors)
    return false unless input.length == 4
    input.all? { |color| available_colors.include?(color.to_sym) }
  end
end