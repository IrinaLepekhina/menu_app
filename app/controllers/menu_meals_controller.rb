# frozen_string_literal: true

class MenuMealsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :update, :destroy, :edit]

  def show
    @menu_meal = MenuMeal.find(params[:id])
  end

  def index
    @menu_meals = MenuMeal.all
  end

  def new
    @menu_meal = MenuMeal.new
  end

  def create
    @menu_meal = MenuMeal.new(menu_meal_params)
    if @menu_meal.save
      redirect_to menu_meal_path(@menu_meal), notice: 'Menu was filled'
    else
      render :new
    end
  end

  def edit
    @menu_meal = MenuMeal.find(params[:id])
  end
  
  def update
    @menu_meal = MenuMeal.find(params[:id])
    if @menu_meal.update(menu_meal_params)
      redirect_to menu_meal_path(@menu_meal), notice: 'Menu has been updated'
    else
      render :edit
    end
  end
  
  def destroy
    @menu_meal = MenuMeal.find(params[:id])
    @menu_meal.destroy
    redirect_to menu_meals_path, notice: 'Menu has been destroyed'
  end

  private

  def menu_meal_params
    params.require(:menu_meal).permit(:menu_id, :meal_id, :price)
  end
end

# menu.menu_meals.create(meal: meal)
