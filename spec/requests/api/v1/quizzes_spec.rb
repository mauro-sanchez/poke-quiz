require 'rails_helper'

RSpec.describe 'Api::V1::Quizzes', type: :request do
  describe 'GET /index' do
    context 'Creating user and quiz' do
      before do
        @user = FactoryBot.create(:user, email: 'api_testing@test.cl', username: 'api_test')
        @user.save!
        @quiz = FactoryBot.create(:quiz, user: @user)
        @quiz.save!
        get '/api/v1/quizzes'
      end
      it 'Get quizzes with users as JSON' do
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to include('json')
      end
      it 'Expected JSON to have 1 entry' do
        expect(JSON.parse(response.body).length).to eq(1)
      end
      it "Expected username in jSON to equal 'api_test'" do
        expect(JSON.parse(response.body).first['user']).to eq('api_test')
      end
    end
  end
end
