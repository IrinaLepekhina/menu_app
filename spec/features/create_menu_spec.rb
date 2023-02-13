# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/new_menu_form'
require_relative '../support/login_form'

describe 'create new menu NOT NESTED' do
  let(:new_menu_form) { NewMenuForm.new }
  let(:login_form) { LoginForm.new }
  let(:user) { create(:user) }

  before do
    login_form.visit_page.login_as(user)
    category = create(:category, title: "Main dish")
  end

  it 'create new menu with valid date' do
    new_menu_form.visit_page.fill_in_with(
      title: 'X day'
    ).submit

    expect(page).to have_content('Menu has been created')
    expect(Menu.last.title).to eq('X day')
  end

  it 'cannot create new menu with invalid date' do
    new_menu_form.visit_page.submit

    expect(page).to have_content("can't be blank")
  end
end
