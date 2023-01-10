class MenuMeal < ApplicationRecord
  belongs_to :menu
  belongs_to :meal

  validates :menu_id, presence: true
  validates :meal_id, presence: true
  validates :price, presence: true
end


# menu.menu_meals.create(meal: meal)