FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    sequence(:email) { "email#{n}@email" }
    sequence(:nickname) { "nickname#{n}" }
  end
end
