FactoryBot.define do
  factory :meal do
    title { "MyString" }
    price_type { "MyString" }
    description { "MyText" }
    promo { false }
    cover_image { "MyString" }
    price_init { "9.99" }
    category { nil }
  end
end
