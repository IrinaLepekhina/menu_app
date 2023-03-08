# frozen_string_literal: true
module Api
  class UsersController < ApiController
    skip_before_action :authorize_request, only: :create
    skip_before_action :verify_authenticity_token, :only => :create

    # POST /signup
    # return authenticated token upon signup
    def create
      @user = User.create!(user_params)
      auth_token = AuthenticateUser.new(@user.email, @user.password).call
      response = { message: Message.account_created, auth_token: auth_token }
        
      UserMailer.user_created(User.last.email, User.last.id).deliver_now
        
      json_response(response, :created)
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :nickname, :password)
    end
  end
end  

 