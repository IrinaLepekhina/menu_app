class ApiController < ActionController::Base
    helper_method :current_user

    protect_from_forgery with: :null_session
  
    private
  
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  
    def authenticate_user!
      return if current_user
  
      if request.xhr?
        render json: { msg: "Вы не авторизованы" }, status: :forbidden
      else
        redirect_to new_session_path
      end
    end
  end