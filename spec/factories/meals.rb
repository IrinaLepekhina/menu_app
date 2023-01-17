FactoryBot.define do
  factory :meal do
    sequence(:title) { |n| "Meal #{n}" }
    description { "description" }
    price_type { :per_unit }
    promo { false }
    cover_image { "some_file.png" }
    price_init { "200.5" }
    category { Category.all.sample }

    # subfactory
    factory :by_weight do
      sequence(:title) { |n| "Meal #{n} by_weight" }
      price_type { :by_weight }
    end
  end
end
