# frozen_string_literal: true

class MenuMealsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def render_formats(target)
    respond_to do |format|
      format.html
      format.json { render json: target }
    end
  end

  def index
    @menu_meals = MenuMeal
      .order(created_at: :asc, menu_title: :desc)
      .joins(:menu)    
      .joins(:meal)
      .select("menu_meals.*, menus.title as menu_title, menus.date as menu_date, meals.title as meal_title")
      .page(params[:page]).per(10)

      render_formats(@menu_meals)
  end

  def show
    @menu_meal = MenuMeal.find(params[:id])

    render_formats(@menu_meal)
  end

  def new
    @menu_meal = MenuMeal.new

    render_formats(@menu_meal)
  end

  def edit
    @menu_meal = MenuMeal.find(params[:id])

    render_formats(@menu_meal)
  end

  def create
    @menu_meal = MenuMeal.new(menu_meal_params)

    if @menu_meal.save
      respond_to do |format|
        format.html { redirect_to menu_meal_url(@menu_meal), notice: 'Meal was added to Menu' }
        format.json { render json: @menu_meal }
      end
    else
      # flash[:alert] = 'not created'
      render :new
    end
  end

  def update
    @menu_meal = MenuMeal.find(params[:id])

    if @menu_meal.update(menu_meal_params)
      respond_to do |format|
        format.html { redirect_to menu_meal_url(@menu_meal), notice: 'Menu item has been updated' }
        format.json { render json: @menu_meal }
      end
    else
      flash[:alert] = 'not updated'
      render :edit
    end
  end

  def destroy
    @menu_meal = MenuMeal.find(params[:id])

    if @menu_meal.destroy
      respond_to do |format|
        format.html { redirect_to menu_meals_url, notice: 'Meal item was excluded' }
        # format.json { render json: }
      end
    else
      redirect_to menu_meal_url(@menu_meal), notice: "Cannot delete meal itam"
    end
  end

  private

  def menu_meal_params
    params.require(:menu_meal).permit(:menu_id, :meal_id, :price)
  end
end

# if add nested menu -> meal
# menu.menu_meals.create(meal: meal)
