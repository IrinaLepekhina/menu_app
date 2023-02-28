class MealSerializer < ApplicationSerializer
  attribute :title, key: :meal_title
  attributes :id, :category_title

  # def category_title
  #   object.category.title
  # end
end
