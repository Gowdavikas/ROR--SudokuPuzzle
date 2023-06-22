class SudokuSolverController < ApplicationController
    
    def solve
    unsolved_puzzle = params[:puzzle]
    solved_puzzle = solve_sudoku(unsolved_puzzle)
    render json: {
        message: "Given Sudoku--Puzzle solved successfully",
        solved_puzzle: [solved_puzzle]}
  end

  private
  def solve_sudoku(puzzle)
  solve_recursive(puzzle)
end

def solve_recursive(puzzle)
  row, col = find_empty_cell(puzzle)

  return puzzle if row.nil? || col.nil?

  (1..9).to_a.shuffle.each do |num|
    if valid_move?(puzzle, row, col, num)
      puzzle[row][col] = num

      if solve_recursive(puzzle)
        return puzzle
      else
        puzzle[row][col] = 0
      end
    end
  end

  nil
end

def find_empty_cell(puzzle)
  (0..8).each do |row|
    (0..8).each do |col|
      return [row, col] if puzzle[row][col] == 0
    end
  end
  nil
end

def valid_move?(puzzle, row, col, num)
  !row_contains?(puzzle, row, num) &&
    !col_contains?(puzzle, col, num) &&
    !box_contains?(puzzle, row - row % 3, col - col % 3, num)
end

def row_contains?(puzzle, row, num)
  puzzle[row].include?(num)
end

def col_contains?(puzzle, col, num)
  (0..8).each do |row|
    return true if puzzle[row][col] == num
  end
  false
end

def box_contains?(puzzle, start_row, start_col, num)
  (0..2).each do |row|
    (0..2).each do |col|
      return true if puzzle[start_row + row][start_col + col] == num
    end
  end
  false
end

end
