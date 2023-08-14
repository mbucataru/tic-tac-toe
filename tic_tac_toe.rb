module Checks
  def check_win(board)

  end

  def check_move(move)

  end
end

class Board
  def initialize
    @grid = Array.new(3) { Array.new(3, 'B') }
  end
  # move is going to have the format of 1 2
  # 1 2 means place on row 1 column 2
  def make_move(move_row, move_column)

  end
end

class Game
  include Checks

  def initialize
    @board = Board.new
  end

  attr_accessor :board

  def move(move)
    move = move.split
    if check_move(move)
      move_row = move[0].to_i - 1
      move_column = move[1].to_i - 1
      board.make_move(move_row, move_column)
    else
      false
    end

end
