# Contains the logic for various states the Game class needs to check for
module Checks
  def over?(board)

  end

  def move_valid?(move_row, move_column, grid)
    if move_row.negative? || move_row > 2 || move_column.negative? || move_column > 2 || grid[move_row][move_column] != 'B'
      return false
    end

    true
  end

end

# Contains the logic for building and augmenting the board in the game
class Board
  def initialize
    @grid = Array.new(3) { Array.new(3, 'B') }
  end

  attr_reader :grid

  def to_s
    @grid.map { |row| row.join(' | ') }.join("\n#{'-' * 10}\n")
  end
  # move is going to have the format of 1 2
  # 1 2 means place on row 1 column 2
  def make_move(move_row, move_column, player)
    grid[move_row][move_column] = player
  end
end

# Includes the logic for the game of Tic-Tac-Toe
class Game
  include Checks

  def initialize
    @board = Board.new
    @player = 'X'
  end

  attr_reader :board
  attr_accessor :player

  def move(move)
    move = move.split
    move_row = move[0].to_i - 1
    move_column = move[1].to_i - 1
    if move_valid?(move_row, move_column, board.grid)
      board.make_move(move_row, move_column, player)
      self.player = player == 'X' ? 'O' : 'X'
    else
      false
    end

  end
end

# Includes the logic for using the Game class to play a full game
class TicTacToe
  include Checks

  def self.play
    game = Game.new
    until game.over?(game.board)
      puts game.board
      puts "It is Player #{game.player}'s turn: \n"
      user_move = gets.chomp
      game.move(user_move)
    end
  end
end

TicTacToe.play
