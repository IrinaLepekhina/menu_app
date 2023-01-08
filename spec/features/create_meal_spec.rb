# frozen_string_literal: true

require 'rails_helper'

describe 'create new meal' do
  it 'create new meal with valid date' do
    visit('/')
    click_on('New Meal')
    fill_in('Title', with: 'Olivie')
    fill_in('Price', with: '134.5')
    fill_in('Description', with: 'New Year russian salat')
    check('Promo meal')
    attach_file('Cover image', "#{Rails.root}/spec/fixtures/cover_image.png")
    select('per unit', from: 'Price type') # by weight
    select('Salat', from: 'Category')

    click_on('Create Meal')

    expect(page).to have_content('Meal has been created')
    expect(Meal.last.title).to eq('Olivie')
  end


  it 'cannot create new meal with invalid date' do
    visit('/')
    click_on('New Meal')

    click_on('Create Meal')
    expect(page).to have_content("can't be blank")
  end
end
