# # frozen_string_literal: true

# require 'rails_helper'

# describe 'create new menu' do
#   it 'create new menu with valid date' do
#     visit('/')
#     click_on('New Menu')

#     fill_in('Title', with: 'NY menu 23-24')
#     fill_in('Date', with: '31.12.2023')

#     click_on('Create Menu')

#     expect(page).to have_content('Menu has been created')
#     expect(Menu.last.title).to eq('NY menu 23-24')
#   end


#   it 'cannot create new menu with invalid date' do
#     visit('/')
#     click_on('New Menu')

#     click_on('Create Menu')
#     expect(page).to have_content("can't be blank")
#   end
# end