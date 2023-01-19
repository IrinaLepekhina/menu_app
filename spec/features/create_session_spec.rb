  # frozen_string_literal: true

  require 'rails_helper'
  require_relative '../support/new_session_form'
  
  describe 'create new session' do
    let(:new_session_form) { NewSessionForm.new }
    let(:user) { FactoryBot.create(:user, email: 'e_mail@email') }

    it 'user is logged in with valid date' do
      new_session_form.visit_page.fill_in_with(
        email: 'e_mail@email'
      ).submit
  
      expect(page).to have_content('you are logged in')
      # expect(session[:user_id]).to eq(user.id)
    end
  
    it 'user cannot log in with invalid date' do
      new_session_form.visit_page.submit
      expect(page).to have_content("incorrect password or email")
    end
  end