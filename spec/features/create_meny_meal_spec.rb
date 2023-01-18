# # frozen_string_literal: true

# require 'rails_helper'

# describe 'fill menu with meals' do
#   ## implement factory

#   it 'fill new menu with selected meals' do
#     visit('/')
#     click_on('Fill Menu')

#     select('I day', from: 'Menus')

#     select('Seledka', from: 'Meals')
#     fill_in('Price', with: '124,7')

#     click_on('Add meal')

#     expect(page).to have_content('Menu was filled')
#     # expect(Meal.last.title).to eq('Olivie')
#   end

#   it 'cannot fill menu with invalid date' do
#     visit('/')
#     click_on('Fill Menu')

#     click_on('Add meal')

#     expect(page).to have_content("can't be blank")
#   end
# end
