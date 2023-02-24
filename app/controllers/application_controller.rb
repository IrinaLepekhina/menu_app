class ApplicationController < ActionController::Base
  serialization_scope :view_context

  helper_method :current_user

  private

  def current_user
    # OpenStruct.new(admin?: true)
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    return if current_user

    if request.xhr?
      render json: { msg: "Вы не авторизованы" }, status: :forbidden
    else
      redirect_to new_session_url, notice: "Вы не авторизованы"
    end
  end

  # def default_serializer_options
  #   {root: false}
  # end
end
