# frozen_string_literal: true

class MealsController < ApplicationController
  # before_action :prepare_category
  # before_action :prepare_menu

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

  private

  # def prepare_category
  #   @category = Category.find(params[:category_id])
  # end
  # def prepare_menu
  #   @menu = Menu.find(params[:menu_id])
  # end

  def meal_params
    params.require(:meal).permit(
      :title,
      :category_id,
      :price_type,
      :price_init,
      :description,
      :promo,
      :cover_image,
      menus_attributes: [:title, :date]
    )
  end
end
