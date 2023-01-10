# frozen_string_literal: true

require 'rails_helper'

describe 'fill menu with meals' do
  it 'fill new menu with selected meals' do
    visit('/')
    click_on('Fill Menu')

    select('NY menu 23-24', from: 'Menus')

    select('Olivie', from: 'Meals')
    fill_in('Price', with: '124,7')

    select('Pashtet', from: 'Meals')
    fill_in('Price', with: '100,2')

    click_on('Fill Menu')

    expect(page).to have_content('Menu was filled')
    # expect(Meal.last.title).to eq('Olivie')
  end


#   it 'cannot create new meal with invalid date' do
#     visit('/')
#     click_on('New Meal')

#     click_on('Create Meal')
#     expect(page).to have_content("can't be blank")
#   end
end
