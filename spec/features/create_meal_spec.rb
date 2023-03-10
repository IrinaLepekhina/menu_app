# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/new_meal_form'
require_relative '../support/login_form'

describe 'create new meal NOT NESTED' do
  let(:new_meal_form) { NewMealForm.new }
  let(:login_form) { LoginForm.new }
  let(:user) { create(:user) }

  before do
    login_form.visit_page.login_as(user)
    category = create(:category, title: "Main dish")
  end

  it 'create new meal with valid date' do
    new_meal_form.visit_page.fill_in_with(
      title: 'Okroshka',
      cover_image: 'cover_image.png'
    ).submit

    expect(Meal.last.cover_image_identifier).to eq('cover_image.png')
    expect(page).to have_content('Meal was added')
    expect(Meal.last.title).to eq('Okroshka')
  end

  it 'cannot create new meal with invalid date' do
    new_meal_form.visit_page.submit
    expect(page).to have_content("can't be blank")
  end
end
