class Category < ApplicationRecord
    has_many :meals
    validates :title, presence: true
end
