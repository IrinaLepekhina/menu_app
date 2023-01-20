  # frozen_string_literal: true

  require 'rails_helper'
  require_relative '../support/new_session_form'
  
  describe 'create new session' do
    let(:new_session_form) { NewSessionForm.new }
 
    let(:user) { FactoryBot.create(:user, email: 'email@1', nickname: 'ready_user_x') }

    it 'user is logged in with valid date' do
      user.reload
      new_session_form.visit_page.fill_in_with(
        email: 'email@1'
      ).submit
  
      expect(page).to have_content('you are logged in')
  
      expect(page).to have_content("@ready_user_x")
      expect(page).to have_link("Logout")
      expect(page).to_not have_link("New User")
      expect(page).to_not have_link("Login")
    end
  
    it 'user cannot log in with invalid date' do
      new_session_form.visit_page.submit
      expect(page).to have_content("incorrect password or email")
    end
  end