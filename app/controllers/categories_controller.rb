# frozen_string_literal: true

class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to root_url, notice: 'Category has been created'
    else
      render :new
    end
  end

  def category_params
    params.require(:category).permit(:title)
  end

  # def show
  #   @category = Category.find(params[:id])
  # end
end
