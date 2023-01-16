class Category < ApplicationRecord
  has_many :meals, dependent: :destroy
  validates :title, presence: true
end
