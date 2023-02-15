FactoryBot.define do
  factory :menu_meal do
    menu_id { Menu.all.sample.id }
    meal_id { Meal.all.sample.id }
    price { "9.99" }
  end
end
