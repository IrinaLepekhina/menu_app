class Meal < ApplicationRecord
  belongs_to :category

  has_many :menu_meals, dependent: :destroy
  has_many :menus, through: :menu_meals
  accepts_nested_attributes_for :menus

  validates :title, presence: true
  validates :price_type, presence: true

  enum :price_type, [ :per_unit, :by_weight ] #, default: :per_unit

  def description_html
    ### add check - if exists/not nul
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(description)
  end
end
