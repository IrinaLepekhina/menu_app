class NewSessionForm
  include Capybara::DSL
  
  def visit_page
    visit('/')
    click_on('Login')
    self
  end
  
  def login_as(user)
    fill_in('email', with: params.fetch(:email, 'email@x'))
    
    fill_in('password', with: 'password123')
    click_on('GO')
    self
  end
end