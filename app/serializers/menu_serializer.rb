class MenuSerializer < ActiveModel::Serializer
  attributes :id, :title

  has_many :menu_meals, dependent: :destroy
  has_many :meals, through: :menu_meals
end
