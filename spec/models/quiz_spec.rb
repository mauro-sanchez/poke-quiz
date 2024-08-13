require 'rails_helper'

RSpec.describe Quiz, type: :model do
  subject { Quiz.new }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:score) }
  end

  describe 'On creation' do
    it 'Would be saved' do
      quiz = FactoryBot.build(:quiz)
      quiz.save
      expect(quiz.valid?).to eq(true)
    end

    it "Can't create two users with same email" do
      user = FactoryBot.build(:user, email: 'test2@testing.cl')
      user.save
      invalid_user = FactoryBot.build(:user, username: 'testing2', email: 'test2@testing.cl')
      invalid_user.save
      expect(invalid_user.valid?).to eq(false)
    end

    it "Can't create two users with same username" do
      user = FactoryBot.build(:user, username: 'testing2', email: 'test2@testing.cl')
      user.save
      invalid_user = FactoryBot.build(:user, username: 'testing2', email: 'test3@testing.cl')
      invalid_user.save
      expect(invalid_user.valid?).to eq(false)
    end
  end
end
