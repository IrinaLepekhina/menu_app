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
        context "without nested children" do
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

        context "with nested children" do
          before do
            category = create(:category)
            meal = create(:by_weight_meal)
            @valid_data = { title: "nested menu", date: "2023-02-19", menu_meals_attributes: { "0" => { price: 1, meal_id: meal.id } } }
          end

          it "redirects to menus#show" do
            post :create, params: { menu: @valid_data }
            expect(response).to redirect_to(menu_path(assigns[:menu]))
          end

          it "creates new menu in database" do
            expect do
              post :create, params: { menu: @valid_data }
            end.to change(Menu, :count).by(1)
          end
  
          it "creates new menu_meal in database" do
            expect do
              post :create, params: { menu: @valid_data }
            end.to change(MenuMeal, :count).by(1)
          end
        end
      end
  
      context "invalid data" do
        context 'without nested children' do
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

        context "with nested children" do
          before do
            category = create(:category)
            meal = create(:by_weight_meal)
            @invalid_menu_data = { title: "nested menu", date: "", menu_meals_attributes: { "0" => { price: 1, meal_id: meal.id } } }
            @invalid_menu_meal_data = { title: "nested menu", date: "2023-02-19", menu_meals_attributes: { "0" => { price: nil, meal_id: meal.id } } }
          end

          describe "valid menu, invalid menu_meal" do
            it "renders :new template" do
              post :create, params: { menu: @invalid_menu_data }
              expect(response).to render_template(:new)
            end
      
            it "doesn't create new menu in database" do
              expect do
                post :create, params: { menu: @invalid_menu_data }
              end.not_to change(Menu, :count)
            end

            it "doesn't create new menu_meal in database" do
              expect do
                post :create, params: { menu: @invalid_menu_data }
              end.not_to change(MenuMeal, :count)
            end
          end

          describe "invalid menu, valid menu_meal" do
            it "renders :new template" do
              post :create, params: { menu: @invalid_menu_meal_data }
              expect(response).to redirect_to(menu_path(assigns[:menu]))
            end
      
            it "do create new menu in database" do
              expect do
                post :create, params: { menu: @invalid_menu_meal_data }
              end.to change(Menu, :count).by(1)
            end

            it "doesn't create new meal in database" do
              expect do
                post :create, params: { menu: @invalid_menu_meal_data }
              end.not_to change(MenuMeal, :count)
            end
          end
        end
      end
    end

    describe "PUT update" do
      let(:menu) { create(:menu) }

      context "valid data" do
        context "without nested children" do
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

        context "with nested children" do
          let!(:category) { create(:category) }
          let!(:meal) { create(:by_weight_meal) }
          let!(:menu_meal) { create(:menu_meal, menu_id: menu.id) }

          before do
            put :update, params: { id: menu, menu: { title: "New menu Title", menu_meals_attributes: { id: menu_meal.id, price: 1 } } }
            menu.reload
            menu_meal.reload
          end
          
          it "redirects to menus#show" do
            expect(response).to redirect_to(menu)
          end

          it "updates menu and meal in database" do
            expect(menu.title).to eq("New menu Title")
            expect(menu_meal.price).to eq(1)
          end
        end
      end

      context "invalid data" do
        context "without nested children" do
          let(:invalid_data) { attributes_for(:menu, title: '') }

          it "renders :edit template" do
            put :update, params: { id: menu, menu: invalid_data }
            expect(response).to render_template(:edit)
          end

          it "doesn't update menu in database" do
            put :update, params: { id: menu, menu: invalid_data }
            menu.reload
            expect(menu.title).not_to eq('')
          end
        end

        context "with nested children" do
          let!(:category) { create(:category) }
          let!(:meal) { create(:by_weight_meal) }
          let!(:menu_meal) { create(:menu_meal, menu_id: menu.id) }

          describe "invalid parent, valid children" do
            before do
              put :update, params: { id: menu, menu: { title: '', menu_meals_attributes: { price: 1, id: menu_meal.id } } }
              menu.reload
              menu_meal.reload
            end
            
            it "renders :edit template" do
              expect(response).to render_template(:edit)
            end

            it "doesn't update menu in database" do
              expect(menu.title).not_to eq('')
            end

            it "doesn't update menu_meal in database" do
              expect(menu_meal.price).not_to eq(1)
            end
          end

          describe "valid parent, invalid children" do
            before do
              put :update, params: { id: menu, menu: { title: 'New menu Title', meals_attributes: { title: "", id: meal.id } } }
              menu.reload
              meal.reload
            end

            it "redirects to updated menu" do
              expect(response).to redirect_to menu_path(menu)
            end

            it "do update menu in database" do
              expect(menu.title).to eq('New menu Title')
            end

            it "doesn't update meal in database" do
              expect(meal.title).not_to eq("")
            end
          end
        end
      end
    end

    describe "DELETE destroy" do
      let!(:menu) { create(:menu) }
      let!(:category) { create(:category) }
      let!(:meal) { create(:by_weight_meal) }

      context "nested children are empty" do
        it "redirects to menus#index" do
          delete :destroy, params: { id: menu }
          expect(response).to redirect_to(menus_path)
        end

        it "deletes menu from database" do
          delete :destroy, params: { id: menu }
          expect(Menu).not_to exist(menu.id)
        end
      end

      context "nested children are not empty" do
        describe "delete menu" do
          let!(:menu_meal) { create(:menu_meal, menu_id: menu.id) }

          it "redirects to menus#index" do
            delete :destroy, params: { id: menu }
            expect(response).to redirect_to(menus_path)
          end

          it "do delete menu from database" do
            delete :destroy, params: { id: menu }
            expect(Menu).not_to exist(menu.id)
          end
        end

      end
    end
  end
end
