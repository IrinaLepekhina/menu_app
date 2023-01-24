class NewSessionForm
  include Capybara::DSL

  def visit_page
    visit('/')
    click_on('Login')
    self
  end

  def fill_in_with(params = {})
    fill_in('email', with: params.fetch(:email, 'email@x'))

    fill_in('password', with: 'password123')

    self
  end

  def submit
    click_on('GO')
    self
  end
end
