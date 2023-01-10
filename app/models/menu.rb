class Menu < ApplicationRecord
    has_many :menu_meals
    has_many :meals, through: :menu_meals
    
    validates :title, presence: true
    validates :date, presence: true
end
