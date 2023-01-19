# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/new_meal_form'

describe 'create new meal' do
  let(:new_meal_form) { NewMealForm.new }

  it 'create new meal with valid date' do
    new_meal_form.visit_page.fill_in_with(
      title: 'Okroshka'
    ).submit

    expect(page).to have_content('Meal has been created')
    expect(Meal.last.title).to eq('Okroshka')
  end

  it 'cannot create new meal with invalid date' do
    new_meal_form.visit_page.submit
    expect(page).to have_content("can't be blank")
  end
end
