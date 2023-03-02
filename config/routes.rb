# frozen_string_literal: true


Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :users, only: %i[new create show]
  resource :session, only: %i[new create destroy]

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1) do
      resources :meals
    end
    scope module: :v2, constraints: ApiConstraints.new(version: 2, default: true) do
      resources :meals
    end
  end




















  resources :meals, only: %i[new create show edit destroy update]
  resources :meals do
    get 'page/:page', action: :index, on: :collection
  end

  resources :menu_meals, only: %i[new create show edit destroy update]
  resources :menu_meals do
    get 'page/:page', action: :index, on: :collection
  end

  resources :menus, only: %i[new create show edit destroy update]
  resources :menus do
    get 'page/:page', action: :index, on: :collection
  end

  resources :categories, only: %i[new create show edit destroy update]
  resources :categories do
    get 'page/:page', action: :index, on: :collection
  end
end
