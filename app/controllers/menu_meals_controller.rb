# frozen_string_literal: true

class MenuMealsController < ApplicationController
  # def show
  #   @menu = Menu.find(params[:id])
  # end

  def new
    @menu_meal = MenuMeal.new
  end

  def create
    @menu_meal = MenuMeal.new(menu_meal_params)
    if @menu_meal.save
      redirect_to root_url, notice: 'Menu was filled'
    else
      render :new
    end
  end

  private

  def menu_meal_params
    params.require(:menu_meal).permit(:menu_id, :meal_id, :price)
  end
end

# menu.menu_meals.create(meal: meal)
