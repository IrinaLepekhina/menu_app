class NewCategoryForm
  include Capybara::DSL

  def visit_page
    visit('/categories')
    click_on('create new category')
    save_and_open_page
    self
  end

  def fill_in_with(_params = {})
    fill_in 'Category title', with: 'Soup'

    self
  end

  def submit
    click_button('submit')
    self
  end
end

# _id, collection: Meal.all, label_method: :title, value_method: :id, label: 'Meals'
# _id, collection: Menu.all, label_method: :title, value_method: :id, :prompt => 'Choose an existing Item',
