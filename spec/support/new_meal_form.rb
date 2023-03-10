class NewMealForm
  include Capybara::DSL

  def visit_page
    visit('/')
    click_on('Meals')
    click_on('create new meal')
    self
  end

  def fill_in_with(params = {})
    fill_in('Meal title', with: 'Okroshka')
    fill_in('Price', with: '134.5')
    fill_in('Description', with: 'Okroshka description')
    check('Promo meal')
    attach_file('Cover image', Rails.root.join("spec/fixtures/#{params.fetch(:cover_image, 'cover_image.png')}"))

    select('per unit', from: 'Price type') # by weight
    select('Main dish', from: 'Category')
    self
  end

  def submit
    click_on('submit')
    self
  end
end
