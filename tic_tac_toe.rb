module Checks
  def check_win(board)

  end

  def check_move(move_row, move_column)
    return false if move_row.negative? || move_row > 2 || move_column.negative? || move_column > 2

    true
  end
end

class Board
  def initialize
    @grid = Array.new(3) { Array.new(3, 'B') }
  end

  attr_reader :grid

  # move is going to have the format of 1 2
  # 1 2 means place on row 1 column 2
  def make_move(move_row, move_column, player)
    grid[move_row][move_column] = player
  end
end

class Game
  include Checks

  def initialize
    @board = Board.new
    @player = 'X'
  end

  attr_reader :player, :board

  def move(move)
    move = move.split
    move_row = move[0].to_i - 1
    move_column = move[1].to_i - 1
    if check_move(move_row, move_column)
      board.make_move(move_row, move_column, player)
    else
      false
    end

  end

end
