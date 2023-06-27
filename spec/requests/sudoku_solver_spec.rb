require 'rails_helper'
RSpec.describe SudokuSolverController, type: :controller do
  describe 'POST #solve' do
    context 'with a valid puzzle' do
      let(:valid_puzzle) do
        [
          [5, 3, 0, 0, 7, 0, 0, 0, 0],
          [6, 0, 0, 1, 9, 5, 0, 0, 0],
          [0, 9, 8, 0, 0, 0, 0, 6, 0],
          [8, 0, 0, 0, 6, 0, 0, 0, 3],
          [4, 0, 0, 8, 0, 3, 0, 0, 1],
          [7, 0, 0, 0, 2, 0, 0, 0, 6],
          [0, 6, 0, 0, 0, 0, 2, 8, 0],
          [0, 0, 0, 4, 1, 9, 0, 0, 5],
          [0, 0, 0, 0, 8, 0, 0, 7, 9]
        ]
      end

      before do
        post :solve, params: { puzzle: valid_puzzle }
      end

      it 'returns a success response' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns a success message' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['message']).to eq('Given Sudoku puzzle solved successfully')
      end
    end
  end
end
