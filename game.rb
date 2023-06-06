require_relative("board")
require("byebug")

class Game
  def initialize
    @board = Board.new
    @previous_guess = nil
  end

  def prompt
    puts "Enter a position, ex 0 3"
    input = gets.chomp.split(" ")
    guess = [input[0].to_i, input[1].to_i]
    if guess.length != 2 and (
      guess[0].is_a?(Integer) and guess[1].is_a?(Integer))
      raise RuntimeError.new("Guess was not valid. Please try again")
    end
    guess
  end

  # Returns card at guess position and reveals it.
  def make_guess(guess_position)
    @board.reveal(guess_position)
  end

  # Compares current card with previous guess. Flips them accordingly
  def compared_cards(card)
    if @previous_guess == card
      puts "Found a match!"
    else
      puts "No match found"
      sleep(2)
      @previous_guess.hide
      card.hide
    end
    @previous_guess = nil
  end


  def play
    @board.populate
    while !@board.won?
      @board.render
      guess_pos = self.prompt
      card = self.make_guess(guess_pos)
      if @previous_guess and card
        compared_cards(card)
      elsif card
        @previous_guess = card
      end
    end
    puts "You win!"
  end
end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.play
end
