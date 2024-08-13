require 'rails_helper'

# Feature: Sign in
#   As a user
#   I want to sign in
#   So I can visit protected areas of the site
RSpec.feature 'Sign in', type: :feature do
  # Scenario: User cannot sign in if not registered
  #   Given I do not exist as a user
  #   When I sign in with valid credentials
  #   Then I see an invalid credentials message
  scenario 'User cannot sign in if not registered' do
    signin('test@test.com', 'test1234')
    expect(page).to have_content 'Email/password is invalid!'
  end
  # Scenario: User can sign in with valid credentials
  #   Given I exist as a user
  #   And I am not signed in
  #   When I sign in with valid credentials
  #   Then I see a success message
  scenario 'user can sign in with valid credentials' do
    user = FactoryBot.create(:user)
    signin(user.email, user.password)
    expect(page).to have_content 'Log out!'
  end
  # Scenario: User cannot sign in with wrong email
  #   Given I exist as a user
  #   And I am not signed in
  #   When I sign in with a wrong email
  #   Then I see an invalid email message
  scenario 'user cannot sign in with wrong email' do
    user = FactoryBot.create(:user)
    signin('invalid@test.com', user.password)
    expect(page).to have_content 'Email/password is invalid!'
  end
  # Scenario: User cannot sign in with wrong password
  #   Given I exist as a user
  #   And I am not signed in
  #   When I sign in with a wrong password
  #   Then I see an invalid password message
  scenario 'user cannot sign in with wrong password' do
    user = FactoryBot.create(:user)
    signin(user.email, 'invalidpass')
    expect(page).to have_content 'Email/password is invalid!'
  end
end
