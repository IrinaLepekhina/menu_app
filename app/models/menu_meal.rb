class MenuMeal < ApplicationRecord
  belongs_to :menu
  belongs_to :meal

  validates :price, presence: true # , numericality: true
  # validates :meal_id, uniqueness: { scope: %i[menu_id] }

  def owner=(new_owner)
    self.old_owner = self.owner
    super
  end
end
