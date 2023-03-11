module AuthenticateUserHelper
  include Capybara::DSL

  def signin(user)
    visit('/')
    click_on('Login')
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_button "GO"
    user
  end
end