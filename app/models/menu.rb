class Menu < ApplicationRecord

  has_many :menu_meals, dependent: :destroy
  has_many :meals, through: :menu_meals

  validates_uniqueness_of :title
  validates_presence_of :title, :date

  validates_associated :menu_meals

  accepts_nested_attributes_for :menu_meals, reject_if: :reject_menu_meals

  def reject_menu_meals(attributes)
    attributes['price'].blank?
  end

  def self.next_week
    where(date: Time.zone.now.at_beginning_of_week...Time.zone.now.at_end_of_week)
  end

end
