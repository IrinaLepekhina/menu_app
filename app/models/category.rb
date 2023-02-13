class Category < ApplicationRecord
  has_many :meals, dependent: :restrict_with_error
  validates :title, presence: true, allow_blank: false, uniqueness: { case_sensitive: true }

  validates_associated :meals

  accepts_nested_attributes_for :meals, reject_if: :reject_meals

  def reject_meals(attributes)
    attributes['title'].blank?
  end
end
