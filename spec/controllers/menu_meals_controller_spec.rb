# frozen_string_literal: true

require 'rails_helper'

describe MenuMealsController do
  before do
    category = create(:category)
    menu = create(:menu)
    meal = create(:per_unit_meal)
  end

  shared_examples "public access to menu_meals" do
    describe "GET index" do
      it "renders :index template" do
        get :index
        expect(response).to render_template(:index)
      end

      it "assigns menu_meals to template" do
        menu_meal = create(:menu_meal)
        get :index
        expect(assigns(:menu_meals)).to match_array([menu_meal])
      end
    end

    describe "GET show" do
      let(:menu_meal) { create(:menu_meal) }

      it "renders :show template" do
        get :show, params: { id: menu_meal } # { id: menu_meal.id }
        expect(response).to render_template(:show)
      end

      it "assigns requested menu_meal to @menu_meal" do
        get :show, params: { id: menu_meal }
        expect(assigns(:menu_meal)).to eq(menu_meal)
      end
    end
  end

  describe "guest user" do
    it_behaves_like "public access to menu_meals"

    describe "GET new" do
      it 'redirects to login page' do
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "POST create" do
      let(:valid_data) { attributes_for(:menu_meal) }

      it 'redirects to login page' do
        post :create, params: { menu_meal: valid_data }
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "GET edit" do
      let(:menu_meal) { create(:menu_meal) }

      it 'redirects to login page' do
        get :edit,  params: { id: menu_meal } # { id: meal.id }
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "PUT update" do
      let(:menu_meal) { create(:menu_meal) }
      let(:valid_data) { attributes_for(:menu_meal, title: "New Title") }

      it 'redirects to login page' do
        put :update, params: { id: menu_meal, menu_meal: valid_data }
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "DELETE destroy" do
      let(:menu_meal) { create(:menu_meal) }

      it 'redirects to login page' do
        delete :destroy, params: { id: menu_meal }
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe "authenticated user" do
    let(:user) { create(:user, password: 'password123') }

    before do
      user&.authenticate('password123')
      request.session[:user_id] = user.id
    end

    it_behaves_like "public access to menu_meals"

    describe "GET edit" do
      let(:menu_meal) { create(:menu_meal) }

      it "renders :edit template" do
        get :edit, params: { id: menu_meal } # { id: meal.id }
        expect(response).to render_template(:edit)
      end

      it "assigns requested menu_meal to template" do
        get :edit, params: { id: menu_meal }
        expect(assigns(:menu_meal)).to eq(menu_meal)
      end
    end

    describe "GET new" do
      it "renders :new template" do
        get :new
        expect(response).to render_template(:new)
      end

      it "assigns new menu_meal to @menu_meal / to template" do
        get :new
        expect(assigns(:menu_meal)).to be_a_new(MenuMeal)
      end
    end

    describe "POST create" do
      let(:valid_data) { attributes_for(:menu_meal) }

      context "valid data" do
        it "redirects to menu_meals#show" do
          post :create, params: { menu_meal: valid_data }
          expect(response).to redirect_to(menu_meal_path(assigns[:menu_meal]))
        end

        it "creates new menu_meal in database" do
          expect do
            post :create, params: { menu_meal: valid_data }
          end.to change(MenuMeal, :count).by(1)
        end
      end

      context "invalid data" do
        let(:invalid_data) { attributes_for(:menu_meal, price: '') }

        it "renders :new template" do
          post :create, params: { menu_meal: invalid_data }
          expect(response).to render_template(:new)
        end

        it "doesn't create new menu_meal in database" do
          expect do
            post :create, params: { menu_meal: invalid_data }
          end.not_to change(MenuMeal, :count)
        end
      end
    end

    describe "PUT update" do
      let(:menu_meal) { create(:menu_meal) }

      context "valid data" do
        let(:valid_data) { attributes_for(:menu_meal, price: 10) }

        it "redirects to menu_meals#show" do
          put :update, params: { id: menu_meal, menu_meal: valid_data }
          expect(response).to redirect_to(menu_meal)
        end

        it "updates menu_meal in database" do
          put :update, params: { id: menu_meal, menu_meal: valid_data }
          menu_meal.reload
          expect(menu_meal.price).to eq(10)
        end
      end

      context "invalid data" do
        let(:invalid_data) { attributes_for(:menu_meal, price: nil) }

        it "renders :edit template" do
          put :update, params: { id: menu_meal, menu_meal: invalid_data }
          expect(response).to render_template(:edit)
        end

        it "doesn't updates meal in database" do
          put :update, params: { id: menu_meal, menu_meal: invalid_data }
          menu_meal.reload
          expect(menu_meal.price).not_to be_nil
        end
      end
    end

    describe "DELETE destroy" do
      let(:menu_meal) { create(:menu_meal) }

      it "redirects to menu_meals#index" do
        delete :destroy, params: { id: menu_meal }
        expect(response).to redirect_to(menu_meals_path)
      end

      it "deletes menu_meal from database" do
        delete :destroy, params: { id: menu_meal }
        expect(MenuMeal).not_to exist(menu_meal.id)
      end
    end
  end
end
