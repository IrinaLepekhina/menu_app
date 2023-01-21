class ApplicationController < ActionController::Base
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    unless current_user
      if request.xhr?
        render json: {msg: "Вы не авторизованы"}, status: 403            
      else
        redirect_to new_session_path
      end
    end
  end

end






