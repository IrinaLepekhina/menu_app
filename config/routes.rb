# frozen_string_literal: true

Rails.application.routes.draw do
  resources :meals
  root to: 'welcome#index'
  
  resources :categories, only: %i[new create show]
  resources :menus, only: %i[new create show]
  resources :menu_meals, only: %i[new create show]
  resources :users, only: %i[new create show]

  resource :session, only: %i[new create destroy]
end