class NewMenuForm
  include Capybara::DSL

  def visit_page
    visit('/')
    click_on('New Menu')
    self
  end

  def fill_in_with(params = {})
    fill_in('Title', with: 'X day')
    fill_in('Date', with: '08.03.2023')
    self
  end

  def submit
    click_on('Create Menu')
    self
  end
end