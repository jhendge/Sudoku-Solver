require_relative 'sudoku'

describe Sudoku do
  let(:seed) {'105802000090076405200400819019007306762083090000061050007600030430020501600308900'}
  let(:solved_board) {'145892673893176425276435819519247386762583194384961752957614238438729561621358947'}
  let(:game) { Sudoku.new(seed) }

  # 1|0|5| 8|0|2| 0|0|0
  # 0|9|0| 0|7|6| 4|0|5
  # 2|0|0| 4|0|0| 8|1|9
  #
  # 0|1|9| 0|0|7| 3|0|6
  # 7|6|2| 0|8|3| 0|9|0
  # 0|0|0| 0|6|1| 0|5|0
  #
  # 0|0|7| 6|0|0| 0|3|0
  # 4|3|0| 0|2|0| 5|0|1
  # 6|0|0| 3|0|8| 9|0|0

  describe 'calculating indices' do
    describe '#row_index' do
      it 'should return the row based on the index' do
        expect(game.row_index(0)).to eq(0)
        expect(game.row_index(9)).to eq(1)
        expect(game.row_index(10)).to eq(1)
        expect(game.row_index(71)).to eq(7)
      end
    end

    describe '#col_index' do
      it 'should return the column based on the index' do
        expect(game.col_index(0)).to eq(0)
        expect(game.col_index(9)).to eq(0)
        expect(game.col_index(79)).to eq(7)
      end
    end

    describe '#sector_index' do
      it 'should return the sub-grid based on the index' do
        expect(game.sector_index(0)).to eq(0)
        expect(game.sector_index(9)).to eq(0)
        expect(game.sector_index(57)).to eq(7)
      end
    end
  end

  context 'returning cell groups' do
    describe '#row' do
      it 'should return row by index' do
        expect(game.row(0)).to eq([1,0,5,8,0,2,0,0,0])
        expect(game.row(9)).to eq([0,9,0,0,7,6,4,0,5])
        expect(game.row(75)).to eq([6,0,0,3,0,8,9,0,0])
      end
    end

    describe '#col' do
      it 'should return col by index' do
        expect(game.col(0)).to eq([1,0,2,0,7,0,0,4,6])
        expect(game.col(8)).to eq([0,5,9,6,0,0,0,1,0])
      end
    end

    describe '#sector' do
      it 'should return sector by index' do
        expect(game.sector(0)).to eq([1,0,5,0,9,0,2,0,0])
        expect(game.sector(79)).to eq([0,3,0,5,0,1,9,0,0])
      end
    end

    describe '#rows' do
      it 'should return all rows' do
        expect(game.rows).to eq([
          [1,0,5,8,0,2,0,0,0],
          [0,9,0,0,7,6,4,0,5],
          [2,0,0,4,0,0,8,1,9],
          [0,1,9,0,0,7,3,0,6],
          [7,6,2,0,8,3,0,9,0],
          [0,0,0,0,6,1,0,5,0],
          [0,0,7,6,0,0,0,3,0],
          [4,3,0,0,2,0,5,0,1],
          [6,0,0,3,0,8,9,0,0],
        ])
      end
    end

    describe '#columns' do
      it 'should return all columns' do
        expect(game.columns).to eq([
          [1,0,2,0,7,0,0,4,6],
          [0,9,0,1,6,0,0,3,0],
          [5,0,0,9,2,0,7,0,0],
          [8,0,4,0,0,0,6,0,3],
          [0,7,0,0,8,6,0,2,0],
          [2,6,0,7,3,1,0,0,8],
          [0,4,8,3,0,0,0,5,9],
          [0,0,1,0,9,5,3,0,0],
          [0,5,9,6,0,0,0,1,0]
        ])
      end
    end

    describe '#sectors' do
      it 'should return all sectors' do
        expect(game.sectors).to eq([
          [1,0,5,0,9,0,2,0,0],
          [8,0,2,0,7,6,4,0,0],
          [0,0,0,4,0,5,8,1,9],
          [0,1,9,7,6,2,0,0,0],
          [0,0,7,0,8,3,0,6,1],
          [3,0,6,0,9,0,0,5,0],
          [0,0,7,4,3,0,6,0,0],
          [6,0,0,0,2,0,3,0,8],
          [0,3,0,5,0,1,9,0,0]
        ])
      end
    end
  end

  describe '#possibilities' do
    it 'should show all possibilities for a cell' do
      expect(game.possibilities(1)).to eq([4,7])
      expect(game.possibilities(80)).to eq([2,4,7])
    end
  end

  describe '#empty_positions' do
    it 'should indices of all empty cells' do
      expect(game.empty_positions).to eq([
        1, 4, 6, 7, 8, 9, 11, 12, 16, 19,
        20, 22, 23, 27, 30, 31, 34, 39,
        42, 44, 45, 46, 47, 48, 51, 53,
        54, 55, 58, 59, 60, 62, 65, 66,
        68, 70, 73, 74, 76, 79, 80
      ])
    end
  end

  describe '#logic_pass' do
    it 'should find all logical solutions' do
      game.solve!
      expect(game.board_string).to eq(solved_board)
      expect(game.valid?).to be(true)
    end
  end

  describe '#valid?' do
    it 'should know if a board is invalid' do
      expect(game).to_not be_valid
    end

    it 'should know if a board is valid' do
      solved_game = Sudoku.new(solved_board)
      expect(solved_game).to be_valid
    end
  end

end