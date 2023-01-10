class NewMealForm
  include Capybara::DSL

  def visit_page
    visit('/')
    click_on('New Meal')
    self
  end

  def fill_in_with(params = {})
    fill_in('Title', with: 'Milk')
    fill_in('Price', with: '134.5')
    fill_in('Description', with: 'Cow milk')
    check('Promo meal')
    attach_file('Cover image', "#{Rails.root}/spec/fixtures/cover_image.png")
    select('per unit', from: 'Price type') # by weight
    select('Drink', from: 'Category')
    self
  end

  def submit
    click_on('Create Meal')
    self
  end
end
