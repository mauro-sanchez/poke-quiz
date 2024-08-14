require 'rails_helper'

RSpec.describe 'Quizzes', type: :request do
  let(:user) { FactoryBot.create(:user) }
  describe 'GET /new' do
    context 'When not authenticated' do
      it 'Should redirect' do
        get '/quizzes/new'
        expect(response).to redirect_to new_session_path
      end
    end
  end

  describe 'Post new Quiz' do
    context 'When not authenticated' do
      it 'Should redirect' do
        post '/quizzes'
        expect(response).to redirect_to new_session_path
      end
    end
    context 'Authenticated, valid pokemon' do
      before do
        post '/sessions/', params: { email: user.email, password: user.password }
      end

      it "Shouldn't redirect" do
        post('/quizzes', params: { "pokemon_id": 1, question: { "category": 'Seed Pokémon' } })
        Rails.logger.debug "RESPONSE: #{response}"
        expect(response).to redirect_to quiz_quiz_result_path(Quiz.last)
      end
    end
  end
end
