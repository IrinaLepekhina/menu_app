class MenuMeal < ApplicationRecord
  belongs_to :menu
  belongs_to :meal

  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :meal_id, uniqueness: { scope: :menu_id, message: "this meal has been already added" }

  after_create :increment_menu_counter
  after_destroy :decrement_menu_counter

  private

  def increment_menu_counter #after_create do
    self.menu.increment!(:items_counter, 1)
  end

  def decrement_menu_counter #after_destroy do
    self.menu.increment!(:items_counter, -1)
  end

  def self.found_by_price(banchmark)
    where("menu_meals.price <= ?", banchmark)
  end

  def self.created_today
    where("created_at > ?", 1.day.ago)
  end

  # def price=(new_price)
  #   self.old_price = self.price
  #   super
  # end

  # def add_item(item)
  #   if menu_meals.include?(item)
  #     menu_meals.where(menu_meal_id: item.id).first(:price)
  #   else
  #     menu_meals.create(menu_meal: item)
  #   end
  # end
end
