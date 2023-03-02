# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate_user! # not implemented in spec

  def new; end

  def create
    user = User.find_by(email: user_params[:email])&.authenticate(user_params[:password])

    if user.present?
      session[:user_id] = user.id
      redirect_to root_url, notice: 'you are logged in'
    else
      flash[:alert] = 'incorrect password or email'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)

    redirect_to root_url, notice: 'buy-buy'
  end

  private

  def user_params
    params.require(:session).permit(:email, :password)
  end
end
