class Category < ApplicationRecord
  has_many :meals, -> { order(title: :asc) }, dependent: :restrict_with_error

  validates :title, presence: { allow_blank: false }
  validates :title, uniqueness: { case_sensitive: false }

  validates_associated :meals

  accepts_nested_attributes_for :meals, allow_destroy: true, reject_if: :reject_meals

  def reject_meals(attributes)
    attributes['title'].blank?
  end
end

# destroy through association
# category = Category.first
# params = { category: { meals_attributes: [{ id: '17', _destroy: '1' }]}}
# category.attributes = params[:category]
# category.meals.detect { |p| p.id == 17 }.marked_for_destruction?
# category.meals.length
# category.save
# category.reload.meals.length

# update through association
# category.meals_attributes = [ { :id => 1, :title => 'Lad' } ]

# custome nested
# def meals_attributes=(meals_attributes)
#   meals_attributes.values.each do |meal_attributes|
#     meal = Meal.find_or_create_by(meal_attributes)
#   end
# end
