class MenuMeal < ApplicationRecord
  belongs_to :menu
  belongs_to :meal

  validates :price, presence: true
end
