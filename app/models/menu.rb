class Menu < ApplicationRecord
  has_many :menu_meals, dependent: :destroy
  has_many :meals, through: :menu_meals

  accepts_nested_attributes_for :meals

  validates :title, presence: true
  validates :date, presence: true

  def meals_attributes=(meal_attributes)
    meal_attributes.each_value do |meal_attribute|
      meal1 = Meal.find_or_create_by(meal_attribute)

      menu_meal = MenuMeal.find_or_create_by(menu: self, meal: meal1)
    end
  end
end
