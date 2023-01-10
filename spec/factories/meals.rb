FactoryBot.define do
  factory :meal do
    sequence(:title) { |n| "Meal #{n}"}
    price_type { "by_weight" }
    description { "description" }
    promo { false }
    cover_image { "some_file.png" }
    price_init { "200.5" }
    category { Category.first }
  end
end
