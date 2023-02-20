# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy, :edit]
  def index
    @categories = Category.includes(:meals).references(:meals) #.to_a
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
    @category.meals.build
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category, notice: 'Category has been created'
    else
      render :new
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to category_path(@category), notice: 'Category has been updated'
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])

    if @category.destroy
      redirect_to categories_path, notice: 'Category has been destroyed'
    else
      redirect_to category_path(@category), notice: "Cannot delete category while meals exist"
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
