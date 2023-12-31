# Contains the logic for various states the Game class needs to check for
module Checks
  def over?(grid, empty_squares)
    return true if empty_squares.zero?

    3.times do |current|
      unless grid[current][0] == ' '
        return true if grid[current][0] == grid[current][1] && grid[current][0] == grid[current][2]
      end

      unless grid[0][current] == ' '
        return true if grid[0][current] == grid[1][current] && grid[0][current] == grid[2][current]
      end
    end

    unless grid[0][0] == ' '
      return true if grid[0][0] == grid[1][1] && grid[0][0] == grid[2][2]
    end

    unless grid[0][2] == ' '
      return true if grid[0][2] == grid[1][1] && grid[0][2] == grid[2][0]
    end

    false
  end

  def move_valid?(move_row, move_column, grid)
    if move_row.negative? || move_row > 2 || move_column.negative? || move_column > 2 || grid[move_row][move_column] != ' '
      return false
    end

    true
  end
end

# Contains the logic for building and augmenting the board in the game
class Board
  def initialize
    @grid = Array.new(3) { Array.new(3, ' ') }
    @empty_squares = 9
  end

  attr_reader :grid
  attr_accessor :empty_squares

  def to_s
    @grid.map { |row| row.join(' | ') }.join("\n#{'-' * 10}\n")
  end

  def make_move(move_row, move_column, player)
    grid[move_row][move_column] = player
    self.empty_squares -= 1
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
      puts 'Invalid move'
      sleep(2)
    end
  end
end

# Includes the logic for using the Game class to play a full game
class TicTacToe
  include Checks

  def self.play
    input = ''
    puts 'Welcome to Tic-Tac-Toe!'
    puts 'To make a move, please use the format: Row Column'
    puts 'For example, if you want to place in the center, type: 2 2'
    sleep(5)
    while input != 'Q'
      play_round
      sleep(8)
      puts 'If you would like to play again, press enter'
      puts 'To quit, press Q and enter'
      input = gets.chomp
    end
  end

  def self.play_round
    game = Game.new
    until game.over?(game.board.grid, game.board.empty_squares)
      puts game.board
      puts "It is Player #{game.player}'s turn: "
      user_move = gets.chomp
      game.move(user_move)
    end
    puts game.board
    if game.board.empty_squares.zero?
      puts 'It was a draw!'
    else
      if game.player == 'X'
        puts 'Player O has won the game!'
      else
        puts 'Player X has won the game!'
      end
    end
  end
end

TicTacToe.play
