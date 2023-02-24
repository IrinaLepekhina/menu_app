# frozen_string_literal: true

class MealsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy, :edit]
  # skip_before_action 

  def index
    @meals = Meal.order(:title).page(params[:page]).per(2)

    respond_to do |format|
      format.html
      format.json { render json: @meals }
    end
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

  def new
    @meal = Meal.new

    respond_to do |format|
      format.html
      format.json { render json: @meal }
    end
  end

  def edit
    @meal = Meal.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @meal }
    end
  end
  
  def show
    @meal = Meal.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @meal }
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
