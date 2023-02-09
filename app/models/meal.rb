class Meal < ApplicationRecord
  belongs_to :category
  has_many :menu_meals, dependent: :destroy #dependent: :restrict_with_error
  has_many :menus, through: :menu_meals

  enum price_type: { per_unit: 0, by_weight: 1 }
  
  validates :title, presence: true, uniqueness: true #uniqueness: { case_sensitive: true }
  validates :price_type, inclusion: { in: price_types.keys }
  
  
  
  
  # accepts_nested_attributes_for :menus
  # accepts_nested_attributes_for :menu_meals
  
  
  
  
  
  
  
  
  mount_uploader :cover_image, CoverImageUploader

  def silly_title
    "#{title} from #{category.title}"
  end

  def self.by_letter(letter)
    includes(:category).where("meals.title LIKE ?", "#{letter}%").order("categories.title")
  end

  def description_html
    ### add check - if exists/not nul
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(description)
  end
end
