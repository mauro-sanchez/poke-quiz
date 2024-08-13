require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'Creates User via POST' do
    let(:the_request) do
      post '/users', params: { user: { username: 'new_user', email: 'new_user@test.cl', password: 'pokequiz' } }
    end
    it 'Should redirect to Quiz' do
      the_request
      expect(response).to redirect_to new_quiz_path
    end
  end
end
