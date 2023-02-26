# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/new_session_form'

describe 'create new session' do
  let(:new_session_form) { NewSessionForm.new }

  let(:user) { create(:user, email: 'first@email', nickname: 'readyUserOne', password: 'password123') }

  it 'user is logged in with valid date' do
    user.reload
    new_session_form.visit_page.fill_in_with(
      email: 'first@email'
    ).submit

    expect(page).to have_content('you are logged in')

    expect(page).to have_content('@readyUserOne')
    expect(page).to have_button('Logout')
    expect(page).not_to have_link('New User')
    expect(page).not_to have_link('Login')
  end

  it 'user cannot login with invalid date' do
    new_session_form.visit_page.submit
    # add wrong password
    expect(page).to have_content('incorrect password or email')
  end
end
