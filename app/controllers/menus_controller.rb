# frozen_string_literal: true

class MenusController < ApplicationController
  # def show
  #   @menu = Menu.find(params[:id])
  # end

  def new
    @menu = Menu.new
    @menu.meals.build
    @menu.menu_meals.build
  end

  def create
    @menu = Menu.new(menu_params)
    if @menu.save
      redirect_to root_url, notice: 'Menu has been created'
    else
      render :new
    end
  end

  private

  def menu_params
    params.require(:menu).permit(
      :title,
      :date,
      meals_attributes: [
        :title, :category_id,
        :price_type, :price_init,
        :description, :promo,
        :cover_image
      ]
    )
  end
end
