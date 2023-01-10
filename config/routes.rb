# frozen_string_literal: true

Rails.application.routes.draw do
  resources :meals, only: %i[new create show]
  root to: 'welcome#index'
  resources :categories, only: %i[new create show]
  resources :menus, only: %i[new create show]
  resources :menu_meals, only: %i[new create show]
end