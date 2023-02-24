class MenuMealSerializer < ApplicationSerializer
  attributes :id, :price, :menu_date, :meal_title

  def menu_date
    object.menu.date
  end

  def meal_title
    object.meal.title
  end
end
