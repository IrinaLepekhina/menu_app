# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/new_category_form'

describe 'create new ONLY category' do
  let(:new_category_form) { NewCategoryForm.new }

  it 'create new category with valid date.' do
    new_category_form.visit_page.fill_in_with(
      title: 'Soup'
    ).submit

    expect(page).to have_content('Category has been created')
    expect(Category.last.title).to eq('Soup')
  end

  it 'cannot create new category with invalid date' do
    new_category_form.visit_page.submit

    expect(page).to have_content("can't be blank")
  end
end
