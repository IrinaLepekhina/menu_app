class Category < ApplicationRecord
  has_many :meals#, dependent: :restrict_with_error
 
  validates_presence_of :title, allow_blank: false
  validates_uniqueness_of :title, case_sensitive: false
  
  validates_associated :meals

  accepts_nested_attributes_for :meals, allow_destroy: true, reject_if: :reject_meals

  def reject_meals(attributes)
    attributes['title'].blank?
  end
end

# category = Category.first
# params = { category: { meals_attributes: [{ id: '17', _destroy: '1' }]}}
# category.attributes = params[:category]
# category.meals.detect { |p| p.id == 17 }.marked_for_destruction?
# category.meals.length
# category.save
# category.reload.meals.length

# category.meals_attributes = [ { :id => 1, :title => 'Lad' } ]