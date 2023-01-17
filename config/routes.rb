# frozen_string_literal: true

Rails.application.routes.draw do
  resources :meals, only: %i[new create show]
  root to: 'welcome#index'
  
  resources :categories, only: %i[new create show]
  resources :menus, only: %i[new create show]
  resources :menu_meals, only: %i[new create show]
end

# # writing routes that communicates the application's design

# resources :products, only: [:index, :show]
# namespace :my do
#   resources :orders, only: [:index, :show]
# end

# namespace :shop do
#   resources :products, only [:index, :show, :new, :create, :edit, :update]
#   resources :orders, only: [:index, :show] do
#     post :confirm, on: :member
#   end
# end

# namespace :my do
#   resource :subscription, only: [:show :new, :create, :edit, :update, :destroy]
# end
