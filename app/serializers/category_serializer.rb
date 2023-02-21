class CategorySerializer < ActiveModel::Serializer
  attributes :id, :title

  has_many :meals, dependent: :restrict_with_error
end
