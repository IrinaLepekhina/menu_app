class NewSessionForm
    include Capybara::DSL
  
    def visit_page
      visit('/')
      click_on('Login')
      self
    end
  
    def fill_in_with(_params = {})
      fill_in('email', with: 'email@email')
      
      # fill_in('password', with: 'password123')

      self
    end
  
    def submit
      click_on('GO')
      self
    end
  end