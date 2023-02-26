class NewUserForm
  include Capybara::DSL

  def visit_page
    visit('/')
    click_on('New User')
    self
  end

  def fill_in_with(_params = {})
    fill_in('name', with: 'Name')
    fill_in('email', with: '0_email@email')
    fill_in('nickname', with: 'my0name')

    fill_in('password', with: 'very_secure')

    self
  end

  def submit
    click_on('Create User')
    self
  end
end
