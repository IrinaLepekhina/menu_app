# frozen_string_literal: true

class MealsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def render_formats(target)
    respond_to do |format|
      format.html
      format.json { render json: target }
    end
  end

  def index
    @meals = Meal
      .order(created_at: :asc, category_title: :desc)
      .joins(:category)
      .select("meals.*, categories.title as category_title")
      .page(params[:page]).per(10)
      
      render_formats(@meals)
  end

  def show
    @meal = Meal.find(params[:id])

    render_formats(@meal)
  end

  def new
    @meal = Meal.new

    render_formats(@meal)
  end

  def edit
    @meal = Meal.find(params[:id])

    render_formats(@meal)
  end

  def create
    @meal = Meal.new(meal_params)

    if @meal.save
      respond_to do |format|
        format.html { redirect_to meal_url(@meal), notice: 'Meal was added' }
        format.json { render json: @meal }
      end
    else
      # flash[:alert] = 'not created'
      render :new
    end
  end

  def update
    @meal = Meal.find(params[:id])

    if @meal.update(meal_params)
      respond_to do |format|
        format.html { redirect_to meal_url(@meal), notice: 'Meal has been updated' }
        format.json { render json: @meal }
      end
    else
      flash[:alert] = 'not updated'
      render :edit
    end
  end

  def destroy
    @meal = Meal.find(params[:id])

    if @meal.destroy
      respond_to do |format|
        format.html { redirect_to meals_path, notice: 'Meal was deleted' }
        # format.json { render json: }
      end
    else
      redirect_to meal_path(@meal), notice: "Cannot delete meal while included in menu"
    end
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
