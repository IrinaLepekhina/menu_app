# frozen_string_literal: true

class CategoriesController < ApplicationController
  def new
    @category = Category.new
    @category.meals.build #3.times { @category.meals.build }
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to root_url, notice: 'Category has been created'
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category)
    .permit(:title,
      meals_attributes: [
        :title, 
        :price_type, 
        :price_init,
        :description, 
        :promo,
        :cover_image
      ])
  end

  # def show
  #   @category = Category.find(params[:id])
  # end
end
