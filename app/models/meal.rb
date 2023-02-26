class Meal < ApplicationRecord
  belongs_to :category
  has_many :menu_meals, dependent: :restrict_with_error
  has_many :menus, through: :menu_meals

  enum price_type: { per_unit: 0, by_weight: 1 }

  validates :price_init, numericality: { greater_than: 0 }
  validates :price_type, inclusion: { in: price_types.keys ,
    message: "%{value} not appropried type" }

  validates :description, :title, :price_type, :price_init, presence: true
  validates :title, uniqueness: true

  mount_uploader :cover_image, CoverImageUploader

  def silly_title
    "#{title} from #{category.title}"
  end

  def self.by_letter(letter)
    includes(:category).where("meals.title LIKE ?", "#{letter}%").order("categories.title")
  end
  # scope :by_letter, ->(letter) { includes(:category).where("meals.title LIKE ?", "#{letter}%").order("categories.title")}
  scope :promo_and_expensive, -> { promo.where('price_init > 500') }

  def description_html
    ### add check - if exists/not nul
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(description)
  end
end

# category
# category=
# build_category
# create_category
# create_category!
# reload_category
# category_changed?
# category_previously_changed?
