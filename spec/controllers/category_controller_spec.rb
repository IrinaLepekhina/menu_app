# frozen_string_literal: true

require 'rails_helper'

describe CategoriesController do
  shared_examples "public access to categories" do
    describe "GET index" do
      it "renders :index template" do
        get :index
        expect(response).to render_template(:index)
      end

      it "assigns categories to template" do
        category = create(:category)
        get :index
        expect(assigns(:categories)).to match_array([category])
      end
    end

    describe "GET show" do
      let(:category) { create(:category) }

      it "renders :show template" do
        get :show, params: { id: category } # { id: category.id }
        expect(response).to render_template(:show)
      end

      it "assigns requested category to @category" do
        get :show, params: { id: category }
        expect(assigns(:category)).to eq(category)
      end
    end
  end

  describe "guest user" do
    it_behaves_like "public access to categories"

    describe "GET new" do
      it 'redirects to login page' do
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "POST create" do
      let(:valid_data) { attributes_for(:category) }

      it 'redirects to login page' do
        post :create, params: { category: valid_data }
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "GET edit" do
      let(:category) { create(:category) }

      it 'redirects to login page' do
        get :edit,  params: { id: category } # { id: category.id }
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "PUT update" do
      let(:category) { create(:category) }
      let(:valid_data) { attributes_for(:category, title: "New Title") }

      it 'redirects to login page' do
        put :update, params: { id: category, category: valid_data }
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "DELETE destroy" do
      let(:category) { create(:category) }

      it 'redirects to login page' do
        delete :destroy, params: { id: category }
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

    it_behaves_like "public access to categories"

    describe "GET edit" do
      let(:category) { create(:category) }

      it "renders :edit template" do
        get :edit, params: { id: category } # { id: category.id }
        expect(response).to render_template(:edit)
      end

      it "assigns requested category to template" do
        get :edit, params: { id: category }
        expect(assigns(:category)).to eq(category)
      end
    end

    describe "GET new" do
      it "renders :new template" do
        get :new
        expect(response).to render_template(:new)
      end

      it "assigns new Category to @category/to template" do
        get :new
        expect(assigns(:category)).to be_a_new(Category)
      end
    end

    describe "POST create" do
      let(:valid_data) { attributes_for(:category) }

      context "valid data" do
        it "redirects to categories#show" do
          post :create, params: { category: valid_data }
          expect(response).to redirect_to(category_path(assigns[:category]))
        end

        it "creates new category in database" do
          expect do
            post :create, params: { category: valid_data }
          end.to change(Category, :count).by(1)
        end
      end

      context "invalid data" do
        let(:invalid_data) { attributes_for(:category, title: '') }

        it "renders :new template" do
          post :create, params: { category: invalid_data }
          expect(response).to render_template(:new)
        end

        it "doesn't create new category in database" do
          expect do
            post :create, params: { category: invalid_data }
          end.not_to change(Category, :count)
        end
      end
    end

    describe "PUT update" do
      let(:category) { create(:category) }

      context "valid data" do
        let(:valid_data) { attributes_for(:category, title: "New Title") }

        it "redirects to categories#show" do
          put :update, params: { id: category, category: valid_data }
          expect(response).to redirect_to(category)
        end

        it "updates category in database" do
          put :update, params: { id: category, category: valid_data }
          category.reload
          expect(category.title).to eq("New Title")
        end
      end

      context "invalid data" do
        let(:invalid_data) { attributes_for(:category, title: '', description: 'new') }

        it "renders :edit template" do
          put :update, params: { id: category, category: invalid_data }
          expect(response).to render_template(:edit)
        end

        it "doesn't updates category in database" do
          put :update, params: { id: category, category: invalid_data }
          category.reload
          expect(category.title).not_to eq("New Title")
        end
      end
    end

    describe "DELETE destroy" do
      let(:category) { create(:category) }

      it "redirects to categories#index" do
        delete :destroy, params: { id: category }
        expect(response).to redirect_to(categories_path)
      end

      it "deletes category from database" do
        delete :destroy, params: { id: category }
        expect(Category).not_to exist(category.id)
      end
    end
  end
end
