class MenuMealSerializer < ActiveModel::Serializer
  attributes :id, :price

  belongs_to :menu
  belongs_to :meal
end
