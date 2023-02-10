class Category < ApplicationRecord
  has_many :meals, dependent: :destroy
  validates :title, presence: true #, allow_blank: false
  # validates :title, uniqueness: { case_sensitive: true }
  # before_destroy :check_dish_in_category

  accepts_nested_attributes_for :meals, reject_if: :reject_meals

  def reject_meals(attributes)
    attributes['title'].blank?
  end
end
