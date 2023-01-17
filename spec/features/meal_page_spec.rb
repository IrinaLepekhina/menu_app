# frozen_string_literal: true

require 'rails_helper'

describe 'meal page' do
  it 'meal public page' do
    # meal = Meal.create(title: 'Just did it', category_id: 3)
    meal = FactoryBot.create(:meal, title: 'Just did it')
    visit("/meals/#{meal.id}")

    expect(page).to have_content('Just did it')

    # meals = FactoryBot.create_list(:by_weight, 3)
    # p meals.inspect
  end

# doesnot search by tags, no difference between 'p', 'em'
  it 'render markdown description' do
    meal = FactoryBot.create(:meal, description: 'That *was* hard')
    visit("/meals/#{meal.id}")

    expect(page).to have_css('em', text: 'was')

    # expect(page).to have_content('<em>was</em>')
  end
end
