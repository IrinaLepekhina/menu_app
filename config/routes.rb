# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'welcome#index'
  resources :meals
  resources :categories
  resources :menus
  
  resources :menu_meals, only: %i[new create show]
  resources :users, only: %i[new create show]

  resource :session, only: %i[new create destroy]

  namespace :api, defaults: { format: :json } do
    resources :meals, only: %i[index]
  end
end
