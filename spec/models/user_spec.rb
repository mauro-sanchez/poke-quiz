require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(email: 'example@testing.cl') }

  describe 'associations' do
    it { is_expected.to have_many(:quizzes) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  describe 'On creation' do
    it 'Would be saved' do
      user = FactoryBot.build(:user)
      user.save
      expect(user.valid?).to eq(true)
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
