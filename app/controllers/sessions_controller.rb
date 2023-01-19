# frozen_string_literal: true

class SessionsController < ApplicationController

  def new
  end
  
  def create
    user = User.find_by(email: user_params[:email])
    if user.present?
      session[:user_id] = user.id
      redirect_to root_url, notice: 'you are logged in'
     else
      flash[:alert] = 'incorrect password or email'
      render :new
    end
  end
  
  def show
  end
    
  private

  def user_params
    params.require(:session).permit(:email)
  end
end