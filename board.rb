require_relative('card')
require("byebug")

class Board
  attr_reader :grid

  def initialize(size=4)
    raise RuntimeError.new("Size must be an even number") if size % 2 != 0
    @size = size
    @grid = Array.new(size) { Array.new(size)}
  end

  def [](position)
    x, y = position
    @grid[x][y]
  end

  def []=(position, value)
    x, y = position
    @grid[x][y] = value
  end

  def populate
    # Create a list of card pairs in a random order.
    cards = []
    ("A".."Z").to_a[0,(@size ** 2)/2].each do |card_value|
        2.times { cards << Card.new(card_value) }
    end
    cards.shuffle!
    # Populate grid with card pairs
    (0...@size).each do |row|
      (0...@size).each do |col|
        @grid[row][col] = cards.pop
      end
    end
  end

  def render
    # print out a representation of a board's current state
    # iterate over grid and cards. Consider faceup state.
    header = " "
    (0...@grid.length).each { |num| header += " #{num}" }
    puts header
    @grid.each_with_index do |row, idx|
      row_string = "#{idx}"
      row.each do |card|
        if card.faceup
          row_string += " #{card.value}"
        else
          row_string += "  "
        end
      end
      puts row_string
    end
  end

  def won?
    @grid.all? do |row|
      row.all? { |card| card.faceup }
    end
  end

  def reveal(guess_position)
    x, y = guess_position
    card = @grid[x][y]
    if card.faceup
      puts "Card is already revealed at #{x}, #{y}"
    else
      card.reveal
      self.render
      card
    end
  end
end


if __FILE__ == $PROGRAM_NAME
  b = Board.new(4)
  b.populate
  b.render
  b.reveal([0,0])
  b.reveal([3,3])
  b.render
end
