# frozen_string_literal: true

require 'rails_helper'

describe  MealsController do
  describe "GET new" do
    it "renders :new template" do
        get :new
        expect(response).to render_template(:new)
    end


    it "assigns new Meal to @meal" do
        get :new
        expect(assigns(:meal)).to be_a_new(Meal)
    end
  end


  describe "GET show" do
    let(:meal) { FactoryBot.create(:per_unit_meal)}

    it "renders :show template" do
      get :show,  params: { id: meal } #{ id: meal.id }
      expect(response).to render_template(:show)
    end

    it "assigns requested meal to @meal" do
      get :show,  params: { id: meal }
      expect(assigns(:meal)).to eq(meal)
    end
  end

  describe "POST create" do
    it "redirects to meals#show" do

      post :create, meal: FactoryBot.attributes_for(:meal)
      expect(response).to redirect_to(meal_path(assigns[:meal]))
    end

     it "creates new meal in database" do
    end

  end
end
