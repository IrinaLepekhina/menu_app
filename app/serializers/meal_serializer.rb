class MealSerializer < ActiveModel::Serializer
  attributes :id, :title

  belongs_to :category
  has_many :menu_meals, dependent: :destroy #dependent: :restrict_with_error
  has_many :menus, through: :menu_meals
end



# ActiveModel::Serializer::Adapter::JsonApi.new
# ActiveModelSerializers::Adapter::JsonApi.new