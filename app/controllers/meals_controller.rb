# frozen_string_literal: true

class MealsController < ApplicationController
  # before_action :prepare_category
  # before_action :prepare_menu
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy, :edit]

  def index
    @meals = Meal.all
  end

  def show
    @meal = Meal.find(params[:id])
  end

  def new
    @meal = Meal.new
  end

  def edit
    @meal = Meal.find(params[:id])
  end

  def create
    @meal = Meal.new(meal_params)
    if @meal.save
      redirect_to meal_url(@meal), notice: 'Meal has been created'
    else
      render :new
    end
  end

  def update
    @meal = Meal.find(params[:id])

    if @meal.update(meal_params)
      redirect_to meal_path(@meal), notice: 'Meal has been updated'
    else
      render :edit
    end
  end

  def destroy
    Meal.destroy(params[:id])
    redirect_to meals_path, notice: 'Meal has been destroyed'
  end

  private

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

# def prepare_category
#   @category = Category.find(params[:category_id])
# end
# def prepare_menu
#   @menu = Menu.find(params[:menu_id])
# end
