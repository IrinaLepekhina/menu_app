# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/new_menu_form'

describe 'create new ONLY menu' do
  let(:new_menu_form) { NewMenuForm.new }

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
