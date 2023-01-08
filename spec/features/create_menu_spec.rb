# # frozen_string_literal: true

# require 'rails_helper'

# describe 'create new menu' do
#   it 'create new menu with valid date' do
#     visit('/')
#     click_on('New Menu')

#     # fill_in('Title', with: 'NY menu 2023')
#     # fill_in('Price', with: '134.5')

#     # select('per unit', from: 'Price type') # by weight
#     # select('Salat', from: 'Category')

#     click_on('Create Menu')

#     expect(page).to have_content('Menu has been created')
#     expect(Menu.last.title).to eq('NY menu 2023')
#   end


# #   it 'cannot create new menu with invalid date' do
# #     visit('/')
# #     click_on('New Menu')

# #     click_on('Create Menu')
# #     expect(page).to have_content("can't be blank")
# #   end
# end