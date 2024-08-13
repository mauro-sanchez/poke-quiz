FactoryBot.define do
  factory :user, class: User do
    username { 'Test' }
    email { 'test@test.cl' }
    password { 'testing' }
  end
end
