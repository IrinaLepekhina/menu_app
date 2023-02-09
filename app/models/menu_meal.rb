class MenuMeal < ApplicationRecord
  belongs_to :menu
  belongs_to :meal

  validates :price, presence: true #, numericality: true
  # validates :meal_id, uniqueness: { scope: %i[menu_id] }

  #  accepts_nested_attributes_for :meal
end
