require 'rails_helper'

# Feature: Create user
#   To start the quiz and not having an account
#   I want to create an account, to sign in
#   So I can visit protected areas of the site
RSpec.feature 'Create account', type: :feature do
  # Scenario: User cannot sign in if not registered
  #   Given I do not exist as a user
  #   I try to create a user
  #   Then I will be redirected to the quiz page
  scenario 'User creates account and sign in' do
    sign_up_with('test.create.user@test.cl', 'test', 'test.create.user')
    expect(page).to have_content 'Account created!'
  end

  # Scenario: Invalid user cannot be created
  #   Given I do not exist as a user
  #   I try to create a user
  #   But the data is invalid, so I will get an alert
  context 'Trying to create a user with invalid data' do
    scenario 'Empty string as username should fail' do
      sign_up_with('test.create.user@test.cl', 'test', '    ')
      expect(page).to have_content "Username can't be blank"
    end
    scenario 'Empty string as email should fail' do
      sign_up_with('    ', 'test', 'test.create.user')
      expect(page).to have_content "Email can't be blank"
    end
    scenario 'Empty string as password should fail' do
      sign_up_with('test.create.user@test.cl', '    ', 'test.create.user')
      expect(page).to have_content "Password can't be blank"
    end
    scenario 'Invalid email should fail' do
      sign_up_with('test.create.user@test', 'test', 'test.create.user')
      expect(page).to have_content 'Email is invalid'
    end
  end
end
