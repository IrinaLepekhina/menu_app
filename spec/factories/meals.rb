FactoryBot.define do
  factory :meal do
    sequence(:title) { |n| "Meal #{n}" }
    price_type { 1 }
    description { "description" }
    promo { false }
    cover_image { "some_file.png" }
    price_init { "200.5" }
    category { Category.all.sample }

    # subfactory
    factory :per_unit_meal do
      price_type { 0 }
    end
  end
end
