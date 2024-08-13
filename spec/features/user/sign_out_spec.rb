require 'rails_helper'
# Feature: Sign out
#   As a user
#   I want to sign out
#   So I can protect my account from unauthorized access
RSpec.feature 'User::SignOuts', type: :feature do
  # Scenario: User signs out successfully
  #   Given I am signed in
  #   When I sign out
  #   Then I see a signed out message
  scenario 'user signs out successfully' do
    user = FactoryBot.create(:user)
    signin(user.email, user.password)
    expect(page).to have_content 'Log out!'
    click_link 'Log out!'
    expect(page).to have_content 'Signed out!'
  end
end
