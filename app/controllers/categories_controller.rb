# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy, :edit]
  # skip_before_action

  def index
    @categories = Category.order(:title).page(params[:page]).per(10)
    # includes(:meals).references(:meals) #.to_a

    respond_to do |format|
      format.html
      format.json { render json: @categories }
    end
  end

  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @category }
    end
  end

  def new
    @category = Category.new
    @category.meals.build

    respond_to do |format|
      format.html
      format.json { render json: @category }
    end
  end

  def edit
    @category = Category.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @category }
    end
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      respond_to do |format|
        format.html { redirect_to @category, notice: 'Category was added' }
        format.json { render json: @menu_meal }
      end
    else
      # flash[:alert] = 'not created'
      render :new
    end
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
      respond_to do |format|
        format.html { redirect_to category_url(@category), notice: 'Category has been updated' }
        format.json { render json: @category }
      end
    else
      flash[:alert] = 'not updated'
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])

    if @category.destroy
      respond_to do |format|
        format.html { redirect_to categories_url, notice: 'Category has been destroyed' }
        # format.json { render json: }
      end
    else
      redirect_to category_url(@category), notice: "Cannot delete category while meals exist"
    end

    # begin
    #   @category.destroy
    #   redirect_to categories_path, notice: 'Category has been destroyed'
    # rescue ActiveRecord::InvalidForeignKey => e
    #   redirect_to category_path(@category), notice: "Cannot delete category while meals exist" # error.message
    # end
  end

  private

  def category_params
    params.require(:category)
          .permit(:title,
                  meals_attributes: [
                    :id,
                    :category_id,
                    :title,
                    :price_type,
                    :price_init,
                    :description,
                    :promo,
                    :cover_image,
                    :_destroy
                  ])
  end
end
