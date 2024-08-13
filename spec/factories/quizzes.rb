FactoryBot.define do
  factory :quiz do
    association :user
    score { 4 }
    created_at { '2024-08-13 08:18:28' }
    updated_at { '2024-08-13 08:18:28' }
  end
end
