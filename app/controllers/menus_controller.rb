# frozen_string_literal: true

class MenusController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy, :edit]
  # skip_before_action 

  def index
    @menus = Menu.all #includes(:menu_meals).references(:menu_meals) #.to_a

    respond_to do |format|
      format.html
      format.json { render json: @menus, root: "menu_list", adapter: :json} #, root: false, include: ['menu_meals', 'meals' ]}  #.*', 'meals.category'] }
      #render json: @menus, fields: { menus: [:date] }
    end
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

  def new
    @menu = Menu.new
    @menu.menu_meals.build

    respond_to do |format|
      format.html
      format.json { render json: @menu }
    end
  end

  def edit
    @menu = Menu.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @menu }
    end
  end

  def show
    @menu = Menu.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @menu }
    end
  end

  def update
    @menu = Menu.find(params[:id])
    
    if @menu.update(menu_params)
      respond_to do |format|
        format.html { redirect_to menu_url(@menu), notice: 'Menu has been updated'}
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
