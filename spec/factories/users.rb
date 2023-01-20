FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    sequence(:email) { |n| "email#{n}@email" }
    sequence(:nickname) { |n| "nickname#{n}" }
  end
end
