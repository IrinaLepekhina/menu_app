class CategorySerializer < ApplicationSerializer
  attributes :id, :title

  has_many :meals

  class MealSerializer < ApplicationSerializer
    attribute :title, key: :meal_title
    attributes :id
  end
end
