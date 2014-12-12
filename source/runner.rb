#This file reads in a file with several sample boards.

require_relative 'sudoku'

#Set VISUALIZE to true to see the guessing solver do its work.
#This will be slowed down (#sleep) so we can see what's happening.
#Set VISUALIZE to false to simply solve the puzzles
VISUALIZE = true

board_string = File.readlines('sample.unsolved.txt')

board_string.each_with_index do |str,i |
  game = Sudoku.new(str.chomp, VISUALIZE)
  game.clear_screen! if game.visualize?
  puts "Solving #{i}"
  game.solve!
end