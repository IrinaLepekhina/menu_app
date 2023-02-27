class Menu < ApplicationRecord
  has_many :menu_meals, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :meals, through: :menu_meals

  validates :title, uniqueness: true
  validates :title, :date, presence: true

  validates_associated :menu_meals

  accepts_nested_attributes_for :menu_meals, reject_if: :reject_menu_meals

  def reject_menu_meals(attributes)
    attributes['price'].blank?
  end

  def remove_menu_meals(item_to_remove_id)
    menu_meals.where(id: item_to_remove_id).first.try(:destroy)
  end

  def self.next_week
    where(Date.today.beginning_of_week.to_time(:utc)...Date.today.beginning_of_week.to_time(:utc))
  end
end
