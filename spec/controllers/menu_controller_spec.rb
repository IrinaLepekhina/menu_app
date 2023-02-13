# frozen_string_literal: true

require 'rails_helper'

describe MenusController do

  shared_examples "public access to menus" do
    describe "GET index" do
      it "renders :index template" do
        get :index
        expect(response).to render_template(:index)
      end

      it "assigns menus to template" do
        menu = create(:menu)
        get :index
        expect(assigns(:menus)).to match_array([menu])
      end
    end

    describe "GET show" do
      let(:menu) { create(:menu) }

      it "renders :show template" do
        get :show, params: { id: menu } # { id: menu.id }
        expect(response).to render_template(:show)
      end

      it "assigns requested menu to @menu" do
        get :show, params: { id: menu }
        expect(assigns(:menu)).to eq(menu)
      end
    end
  end

  describe "guest user" do
    it_behaves_like "public access to menus"

    describe "GET new" do
      it 'redirects to login page' do
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "POST create" do
      let(:valid_data) { attributes_for(:menu) }

      it 'redirects to login page' do
        post :create, params: { menu: valid_data }
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "GET edit" do
      let(:menu) { create(:menu) }

      it 'redirects to login page' do
        get :edit,  params: { id: menu } # { id: menu.id }
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "PUT update" do
      let(:menu) { create(:menu) }
      let(:valid_data) { attributes_for(:menu, title: "New Title") }

      it 'redirects to login page' do
        put :update, params: { id: menu, menu: valid_data }
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "DELETE destroy" do
      let(:menu) { create(:menu) }

      it 'redirects to login page' do
        delete :destroy, params: { id: menu }
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

    it_behaves_like "public access to menus"

    describe "GET edit" do
      let(:menu) { create(:menu) }

      it "renders :edit template" do
        get :edit, params: { id: menu } # { id: menu.id }
        expect(response).to render_template(:edit)
      end

      it "assigns requested menu to template" do
        get :edit, params: { id: menu }
        expect(assigns(:menu)).to eq(menu)
      end
    end

    describe "GET new" do
      it "renders :new template" do
        get :new
        expect(response).to render_template(:new)
      end

      it "assigns new menu to @menu/to template" do
        get :new
        expect(assigns(:menu)).to be_a_new(Menu)
      end
    end

    describe "POST create" do
      let(:valid_data) { attributes_for(:menu) }

      context "valid data" do
        it "redirects to menus#show" do
          post :create, params: { menu: valid_data }
          expect(response).to redirect_to(menu_path(assigns[:menu]))
        end

        it "creates new menu in database" do
          expect do
            post :create, params: { menu: valid_data }
          end.to change(Menu, :count).by(1)
        end
      end

      context "invalid data" do
        let(:invalid_data) { attributes_for(:menu, title: '') }

        it "renders :new template" do
          post :create, params: { menu: invalid_data }
          expect(response).to render_template(:new)
        end

        it "doesn't create new menu in database" do
          expect do
            post :create, params: { menu: invalid_data }
          end.not_to change(Menu, :count)
        end
      end
    end

    describe "PUT update" do
      let(:menu) { create(:menu) }

      context "valid data" do
        let(:valid_data) { attributes_for(:menu, title: "New Title") }

        it "redirects to menus#show" do
          put :update, params: { id: menu, menu: valid_data }
          expect(response).to redirect_to(menu)
        end

        it "updates menu in database" do
          put :update, params: { id: menu, menu: valid_data }
          menu.reload
          expect(menu.title).to eq("New Title")
        end
      end

      context "invalid data" do
        let(:invalid_data) { attributes_for(:menu, title: '', description: 'new') }

        it "renders :edit template" do
          put :update, params: { id: menu, menu: invalid_data }
          expect(response).to render_template(:edit)
        end

        it "doesn't updates menu in database" do
          put :update, params: { id: menu, menu: invalid_data }
          menu.reload
          expect(menu.title).not_to eq("New Title")
        end
      end
    end

    describe "DELETE destroy" do
      let(:menu) { create(:menu) }

      it "redirects to menus#index" do
        delete :destroy, params: { id: menu }
        expect(response).to redirect_to(menus_path)
      end

      it "deletes menu from database" do
        delete :destroy, params: { id: menu }
        expect(Menu).not_to exist(menu.id)
      end
    end
  end
end
