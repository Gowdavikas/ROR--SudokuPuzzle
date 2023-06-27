Rails.application.routes.draw do


  post 'sudoku', to: 'sudoku_solver#solve'
end
