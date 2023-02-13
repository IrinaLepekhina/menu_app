# frozen_string_literal: true

class MenusController < ApplicationController
  
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy, :edit]
  def index
    @menus = Menu.all
  end
  
  def show
    @menu = Menu.find(params[:id])
  end

  def new
    @menu = Menu.new
    2.times do
      @menu.menu_meals.build
    end
  end

  def create
    @menu = Menu.new(menu_params)
    if @menu.save
      redirect_to @menu, notice: 'Menu has been created'
    else
      render :new
    end
  end
  
  def edit
    @menu = Menu.find(params[:id])
  end
  
  def update
    @menu = Menu.find(params[:id])
    if @menu.update(menu_params)
      redirect_to menu_path(@menu), notice: 'Menu has been updated'
    else
      render :edit
    end
  end
  
  def destroy
    @menu = Menu.find(params[:id])
    @menu.destroy
    redirect_to menus_path, notice: 'Menu has been destroyed'
  end

  private

  def menu_params
    params.require(:menu).permit(
      :title,
      :date,
      menu_meals_attributes: [
        :menu_id,
        :meal_id,
        :price
      ])
  end
end