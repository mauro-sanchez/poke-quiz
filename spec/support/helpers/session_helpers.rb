module Features
  module SessionHelpers
    def sign_up_with(email, password, username)
      visit new_user_path
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in 'Username', with: username
      click_button(id: 'create_account_btn')
    end

    def sign_in(email, password)
      visit new_session_path
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button(id: 'sign_in_button')
    end

    def create_and_sign_in
      user = FactoryBot.create(:user, email: 'testing_login@test.cl', password: 'abcdefgh')
      sign_in user.email, 'abcdefgh'
    end
  end
end
