class MenuMealSerializer < ApplicationSerializer
  attributes :id, :price, :menu_date, :menu_title, :meal_title

  # def menu_date
  #   object.menu.date
  # end

  # def meal_title
  #   object.meal.title
  # end
end
