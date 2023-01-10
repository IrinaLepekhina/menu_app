class NewCategoryForm
  include Capybara::DSL

  def visit_page
    visit('/')
    click_on('New Category')
    self
  end

  def fill_in_with(params = {})
    fill_in('Title', with: 'Soup')
    self
  end

  def submit
    click_on('Create Category')
    self
  end
end
