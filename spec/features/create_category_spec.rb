# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/new_category_form'
require_relative '../support/login_form'

describe 'create new category NOT NESTED' do
  let(:new_category_form) { NewCategoryForm.new }
  let(:login_form) { LoginForm.new }
  let(:user) { create(:user) }

  before do
    login_form.visit_page.login_as(user)
    category = create(:category, title: "Main dish")
  end

  it 'create new category with valid date.' do
    new_category_form.visit_page.fill_in_with(
      title: 'Soup'
    ).submit

    expect(page).to have_content('Category was added')
    expect(Category.last.title).to eq('Soup')
  end

  it 'cannot create new category with invalid date' do
    new_category_form.visit_page.submit

    expect(page).to have_content("can't be blank")
  end
end
