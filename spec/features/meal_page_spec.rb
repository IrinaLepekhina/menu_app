# frozen_string_literal: true

require 'rails_helper'

describe 'meal page' do
  before do
    category = create(:category)
  end

  it 'meal public page' do
    meal = create(:per_unit_meal, title: 'Just did it')
    visit("/meals/#{meal.id}")

    expect(page).to have_content('Just did it')

    # meals = FactoryBot.create_list(:by_weight_meal, 3)
    # p meals.inspect
  end

  # doesnot search by tags, no difference between 'p', 'em'
  it 'render markdown description' do
    meal = create(:per_unit_meal, description: 'That *was* hard')
    visit("/meals/#{meal.id}")

    expect(page).to have_css('em', text: 'was')
  end
end
