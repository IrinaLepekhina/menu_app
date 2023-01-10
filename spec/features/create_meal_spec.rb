# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/new_meal_form.rb'

describe 'create new meal' do
  let(:new_meal_form) { NewMealForm.new }
  # category = FactoryBot.create(:category, title: 'juce')

  it 'create new meal with valid date' do
    new_meal_form.visit_page.fill_in_with(
      title: 'Milk'
  ).submit

    expect(page).to have_content('Meal has been created')
    expect(Meal.last.title).to eq('Milk')
  end

  it 'cannot create new meal with invalid date' do
    new_meal_form.visit_page.submit
    expect(page).to have_content("can't be blank")
  end
end
