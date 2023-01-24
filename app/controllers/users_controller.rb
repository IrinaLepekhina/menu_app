# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    session[:current_time] = Time.zone.now
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_url(@user), notice: 'User has been created'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :nickname, :password)
  end
end
