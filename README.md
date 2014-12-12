Sudoku Solver
=============

[Sudoku](http://en.wikipedia.org/wiki/Sudoku) is a logic-based, combinatorial number-placement puzzle. The objective is to fill a 9×9 grid with digits so that each column, each row, and each of the nine 3×3 sub-grids that compose the grid (also called "boxes") contains the digits from 1 to 9.

Generally, a puzzle provides a partial solution so that some squares already have numbers.  To solve the puzzle, you fill in the unsolved squares.

![Unsolved](http://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Sudoku-by-L2G-20050714.svg/250px-Sudoku-by-L2G-20050714.svg.png) ![Solved Sudoku](http://upload.wikimedia.org/wikipedia/commons/thumb/3/31/Sudoku-by-L2G-20050714_solution.svg/250px-Sudoku-by-L2G-20050714_solution.svg.png)


Included in this repo are 15 unsolved Sudoku puzzles.  The puzzles can be found in the `source/sudoku_puzzles.txt` file.  Five puzzles can be solved with basic logic.  Five require slightly more advanced logic.  Five require educated guessing.  A complete solution will solve all 15 puzzles.


#### Pro Tip #1

Want to enter your own unsolved sudoku puzzle? Head to the `source/sample.unsolved.txt` file and edit the numbers (be sure to use a '0' for empty boxes)

#### Pro Tip #2

Type 'ruby runner.rb' from the command line to see your puzzle being solved in real time!