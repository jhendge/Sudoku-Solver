module SudokuPrettyPrint
  def to_s
    str = ""
    (0..9).each do |row_idx|
      str << row(row_idx*9).join('|') + "\n"
    end
    str
  end

  def clear_screen!
    print "\e[2J"
  end

  #Moves the "cursor" back to the upper left.
  def move_to_home!
    print "\e[H"
  end

  def slow_show
    move_to_home!
    puts self
    sleep(0.01)
  end
end