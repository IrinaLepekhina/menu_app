class Meal < ApplicationRecord
  belongs_to :category
  has_many :menu_meals
  has_many :menus, through: :menu_meals
  
  validates :title, presence: true

  enum price_type: { per_unit: 0, by_weight: 1 }
end
