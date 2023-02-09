class Menu < ApplicationRecord
  has_many :menu_meals, dependent: :destroy
  has_many :meals, through: :menu_meals

  accepts_nested_attributes_for :meals

  validates :title, presence: true
  validates :date, presence: true # , uniqueness: true


  # validates :dish_menus, :date, presence: true
  # validates_associated :dish_menus

  # accepts_nested_attributes_for :dish_menus,
  # allow_destroy: true,
  # reject_if: proc { |attributes| attributes['included'] == '0' || blank? }

  def meals_attributes=(meal_attributes)
    meal_attributes.each_value do |meal_attribute|
      meal1 = Meal.find_or_create_by(meal_attribute)

      menu_meal = MenuMeal.find_or_create_by(menu: self, meal: meal1)
    end
  end
end
