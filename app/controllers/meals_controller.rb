# frozen_string_literal: true

class MealsController < ApplicationController
  def show
    @meal = Meal.find(params[:id])
  end

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(meal_params)
    if @meal.save
      redirect_to root_url, notice: 'Meal has been created'
    else
      render :new
    end
  end

  def meal_params
    params.require(:meal).permit(:title, :categories_id, :price_type, :price_init, :description, :promo, :cover_image) 
  end
end

# bin/rails g model meal title category_id:integer price_type price_init:decimal description:text promo:boolean cover_image
