class MenuMeal < ApplicationRecord
  belongs_to :menu
  belongs_to :meal

  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :meal_id, uniqueness: { scope: :menu_id, message: "this meal has been already added" }

  # def price=(new_price)
  #   self.old_price = self.price
  #   super
  # end
end
