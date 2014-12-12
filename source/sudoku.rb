require_relative 'sudoku_pretty_print'

class Sudoku
  include SudokuPrettyPrint

  def initialize(board, visualize = true)
    @board = board.chars.map(&:to_i)
    @visualize = visualize
  end

  def visualize?
    @visualize
  end

  def board_string
    @board.join('')
  end

  def row_index(cell_idx)
    cell_idx / 9
  end

  def col_index(cell_idx)
    cell_idx % 9
  end

  def sector_index(cell_idx)
    sector_row = row_index(cell_idx) / 3
    sector_column = col_index(cell_idx) / 3
    (sector_row * 3) + sector_column
  end

  def row(cell_idx)
    @board.select
      .with_index{|_, i| row_index(i) == row_index(cell_idx)}
  end

  def col(cell_idx)
    @board.select
      .with_index{|_, i| col_index(i) == col_index(cell_idx)}
  end

  def sector(cell_idx)
    @board.select
      .with_index{|_, i| sector_index(i) == sector_index(cell_idx)}
  end

  def rows
    (0..8).map {|i| row(i * 9)}
  end

  def columns
    (0..8).map {|i| col(i)}
  end

  def sectors
    [sector(0)  , sector(3)  , sector(6),
     sector(27) , sector(30) , sector(33),
     sector(56) , sector(59) , sector(62)]
  end

  def valid?
    rows.all? {|row| valid_group?(row)} &&
    columns.all? {|column| valid_group?(column)} &&
    sectors.all? {|sector| valid_group?(sector)}
  end

  def valid_group?(group)
    group.uniq.length == group.length &&
    (group - (1..9).to_a).empty?
  end

  def possibilities(cell_idx)
    existing_numbers = row(cell_idx) + col(cell_idx) + sector(cell_idx)
    (1..9).to_a - existing_numbers
  end

  def empty_positions
    @board.map.with_index {|cell_value, i| i if cell_value == 0}.compact
  end

  def logically_solvable_positions
    empty_positions
      .select {|cell_idx| possibilities(cell_idx).length == 1}
  end

  def logic_pass
    loop do
      old_board = @board.clone
      logically_solvable_positions.each do |cell_idx|
        @board[cell_idx] = possibilities(cell_idx).first
      end
      break if old_board == @board
    end
  end

  def guess_pass
    unless valid?
      slow_show if visualize?
      cell_idx = empty_positions.first

      possibilities(cell_idx).each do |possible|
        @board[cell_idx] = possible
        break if guess_pass == true
      end

      if !valid?
        @board[cell_idx] = 0
        return false
      end
    end
    true
  end

  def solve!
    logic_pass
    guess_pass
  end
end