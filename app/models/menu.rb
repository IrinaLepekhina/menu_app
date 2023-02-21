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

  def self.next_week
    where(date: Time.zone.now.at_beginning_of_week...Time.zone.now.at_end_of_week)
  end
end
