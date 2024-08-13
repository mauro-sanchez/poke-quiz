require 'rails_helper'

RSpec.feature 'Take quiz!', type: :feature do
  scenario 'Answering a test with random answers, should redirect to Quiz result' do
    fill_questions
    create_and_signin
    expect(page).to have_content 'Taking quiz for this pokemon!'
    # Ensure that selects loaded correctly, when there isn't answers there isn't select tags, and in this page, select tags have .form-select class
    expect(page).to have_css '.form-select'
    click_button(id: 'submit_quiz')
    # Quiz results have random answers
    # You can change 0 to 1 to check null answers
    expect(page).to have_content('You got a score of 0 out of 5')
      .or(have_content('You got a score of 1 out of 5'))
      .or(have_content('You got a score of 2 out of 5'))
      .or(have_content('You got a score of 3 out of 5'))
      .or(have_content('You got a score of 4 out of 5'))
      .or(have_content('You got a score of 5 out of 5'))
  end
end
