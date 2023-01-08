# frozen_string_literal: true

require 'rails_helper'

describe 'create new category' do
  it 'create new category with valid date' do
    visit('/')
    click_on('New Category')
    fill_in('Name', with: 'Soup')

    click_on('Create Category')

    expect(page).to have_content('Category has been created')
    expect(Category.last.name).to eq('Soup')
  end


  it 'cannot create new category with invalid date' do
    visit('/')
    click_on('New Category')

    click_on('Create Category')
    expect(page).to have_content("can't be blank")
  end
end