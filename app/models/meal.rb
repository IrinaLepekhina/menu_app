class Meal < ApplicationRecord
  belongs_to :category
  validates :title, presence: true

  enum price_type: { per_unit: 0, by_weight: 1 }
end
