class ApiController < ActionController::Base
  protect_from_forgery with: :null_session
  
  skip_before_action :authorize_request, only: :authenticate, raise: false
  skip_before_action :verify_authenticity_token, :only => :create
  
  include Response
  include ExceptionHandler

   # called before every action on controllers

  before_action :authorize_request
  attr_reader :current_user

  private

  # Check for valid request token and return user
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end

  include Api
end
