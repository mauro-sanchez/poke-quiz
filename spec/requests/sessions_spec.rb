require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let(:user) { FactoryBot.create(:user) }
  describe 'GET /new' do
    let(:the_request) { get '/sessions/new' }
    context 'when authenticated' do
      # before { create_and_signin }

      it 'No redirect' do
        the_request
        expect(response).to_not be_a_redirect
      end
    end
  end
end
