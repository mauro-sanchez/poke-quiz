require 'rails_helper'

RSpec.describe 'Quizzes', type: :request do
  describe 'GET /new' do
    let(:the_request) { get '/quizzes/new' }
    context 'When not authenticated' do
      it 'Should redirect' do
        the_request
        expect(response).to redirect_to new_session_path
      end
    end
  end
end
