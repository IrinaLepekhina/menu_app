# frozen_string_literal: true

class MenusController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def render_formats(target)
    respond_to do |format|
      format.html
      format.json { render json: target } # , root: false, include: ['menu_meals', 'meals' ]}  #.*', 'meals.category'] }
      # render json: @menus, fields: { menus: [:date] }
    end
  end

  def index
    @menus = Menu
      .includes(:meals).references(:meals)
      .page(params[:page]).per(10)
      
      render_formats(@menus)
  end

  def show
    @menu = Menu.find(params[:id])

    render_formats(@menu)
  end

  def new
    @menu = Menu.new
    @menu.menu_meals.build

    render_formats(@menu)
  end

  def edit
    @menu = Menu.find(params[:id])

    render_formats(@menu)
  end

  def create
    @menu = Menu.new(menu_params)

    if @menu.save
      respond_to do |format|
        format.html { redirect_to menu_url(@menu), notice: 'Menu was added' }
        format.json { render json: @menu_meal }
      end
    else
      # flash[:alert] = 'not created'
      render :new
    end
  end

  def update
    @menu = Menu.find(params[:id])

    if @menu.update(menu_params)
      respond_to do |format|
        format.html { redirect_to menu_url(@menu), notice: 'Menu has been updated' }
        format.json { render json: @menu }
      end
    else
      flash[:alert] = 'not updated'
      render :edit
    end
  end

  def destroy
    @menu = Menu.find(params[:id])

    if @menu.destroy
      respond_to do |format|
        format.html { redirect_to menus_url, notice: 'Menu has been destroyed' }
        # format.json { render json: }
      end
    else
      redirect_to menu_url(@menu), notice: "Cannot delete menu"
    end
  end

  private

  def menu_params
    params.require(:menu).permit(
      :title,
      :date,
      menu_meals_attributes: [
        :id,
        :menu_id,
        :meal_id,
        :price
      ]
    )
  end
end
