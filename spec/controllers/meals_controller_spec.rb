# frozen_string_literal: true

require 'rails_helper'

describe MealsController do
  before do
    category = create(:category)
  end

  shared_examples "public access to meals" do
    describe "GET index" do
      it "renders :index template" do
        get :index
        expect(response).to render_template(:index)
      end

      it "assigns meals to template" do
        by_weight_meal = create(:by_weight_meal)
        per_unit_meal = create(:per_unit_meal)
        get :index
        expect(assigns(:meals)).to match_array([by_weight_meal] + [per_unit_meal])
      end
    end

    describe "GET show" do
      let(:meal) { create(:per_unit_meal) }

      it "renders :show template" do
        get :show, params: { id: meal } # { id: meal.id }
        expect(response).to render_template(:show)
      end

      it "assigns requested meal to @meal" do
        get :show, params: { id: meal }
        expect(assigns(:meal)).to eq(meal)
      end
    end
  end

  describe "guest user" do
    it_behaves_like "public access to meals"

    describe "GET new" do
      it 'redirects to login page' do
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "POST create" do
      let(:valid_data) { attributes_for(:by_weight_meal) }

      it 'redirects to login page' do
        post :create, params: { meal: valid_data }
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "GET edit" do
      let(:meal) { create(:per_unit_meal) }

      it 'redirects to login page' do
        get :edit,  params: { id: meal } # { id: meal.id }
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "PUT update" do
      let(:meal) { create(:by_weight_meal) }
      let(:valid_data) { attributes_for(:by_weight_meal, title: "New Title") }

      it 'redirects to login page' do
        put :update, params: { id: meal, meal: valid_data }
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "DELETE destroy" do
      let(:meal) { create(:by_weight_meal) }

      it 'redirects to login page' do
        delete :destroy, params: { id: meal }
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

    it_behaves_like "public access to meals"

    describe "GET edit" do
      let(:meal) { create(:per_unit_meal) }

      it "renders :edit template" do
        get :edit, params: { id: meal } # { id: meal.id }
        expect(response).to render_template(:edit)
      end

      it "assigns requested meal to template" do
        get :edit, params: { id: meal }
        expect(assigns(:meal)).to eq(meal)
      end
    end

    describe "GET new" do
      it "renders :new template" do
        get :new
        expect(response).to render_template(:new)
      end

      it "assigns new Meal to @meal/to template" do
        get :new
        expect(assigns(:meal)).to be_a_new(Meal)
      end
    end

    describe "POST create" do
      let(:valid_data) { attributes_for(:by_weight_meal, price_init: 1.7) }

      context "valid data" do
        it "redirects to meals#show" do
          post :create, params: { meal: valid_data }
          expect(response).to redirect_to(meal_path(assigns[:meal]))
        end

        it "creates new meal in database" do
          expect do
            post :create, params: { meal: valid_data }
          end.to change(Meal, :count).by(1)
        end

        it "creates pozitive floats price" do
          post :create, params: { meal: valid_data }
          expect(Meal.last.price_init).to be_a(BigDecimal)
          expect(Meal.last.price_init).to be >= 0
        end
      end

      context "invalid data" do
        let(:invalid_data) { attributes_for(:by_weight_meal, title: '') }

        it "renders :new template" do
          post :create, params: { meal: invalid_data }
          expect(response).to render_template(:new)
        end

        it "doesn't create new meal in database" do
          expect do
            post :create, params: { meal: invalid_data }
          end.not_to change(Meal, :count)
        end
      end
    end

    describe "PUT update" do
      let(:meal) { create(:by_weight_meal) }

      context "valid data" do
        let(:valid_data) { attributes_for(:by_weight_meal, title: "New Title") }

        it "redirects to meals#show" do
          put :update, params: { id: meal, meal: valid_data }
          expect(response).to redirect_to(meal)
        end

        it "updates meal in database" do
          put :update, params: { id: meal, meal: valid_data }
          meal.reload
          expect(meal.title).to eq("New Title")
        end
      end

      context "invalid data" do
        let(:invalid_data) { attributes_for(:by_weight_meal, title: '', description: 'new') }

        it "renders :edit template" do
          put :update, params: { id: meal, meal: invalid_data }
          expect(response).to render_template(:edit)
        end

        it "doesn't updates meal in database" do
          put :update, params: { id: meal, meal: invalid_data }
          meal.reload
          expect(meal.title).not_to eq("New Title")
        end
      end
    end

    describe "DELETE destroy" do
      let(:meal) { create(:by_weight_meal) }

      it "redirects to meals#index" do
        delete :destroy, params: { id: meal }
        expect(response).to redirect_to(meals_path)
      end

      it "deletes meal from database" do
        delete :destroy, params: { id: meal }
        expect(Meal).not_to exist(meal.id)
      end
    end
  end
end
