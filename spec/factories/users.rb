FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    email { "email#{n}@email" }
    nickname { "nickname#{n}" }
  end
end
