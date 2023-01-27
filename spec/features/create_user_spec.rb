# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/new_user_form'

describe 'create new user' do
  let(:new_user_form) { NewUserForm.new }

  it 'create new user with valid date' do
    new_user_form.visit_page.fill_in_with(
      email: '0_email@email'
    ).submit

    expect(page).to have_content('User has been created')
    expect(User.last.email).to eq('0_email@email')
    expect(BCrypt::Password.new(User.last.password_digest) == 'very_secure').to be_truthy
    
    expect( ActionMailer::Base.deliveries.count).to eq(1)
    expect( ActionMailer::Base.deliveries.last.to).to include(User.last.email)
  end

  it 'cannot create new user with invalid date' do
    new_user_form.visit_page.submit
    expect(page).to have_content("can't be blank")
  end
end
