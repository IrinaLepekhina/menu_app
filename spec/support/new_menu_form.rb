class NewMenuForm
  include Capybara::DSL

  def visit_page
    visit('/menus')
    click_on('create new menu')
    self
  end

  def fill_in_with(_params = {})
    fill_in('Menu title', with: 'X day')
    fill_in('Date', with: '08.03.2023')
    self
  end

  def submit
    click_on('submit')
    self
  end
end
