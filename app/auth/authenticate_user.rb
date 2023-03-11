# app/auth/authenticate_user.rb
class AuthenticateUser
  def initialize(params = {})
    @email = params[:email]
    @password = params[:password]
  end

  # Service entry point
  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  def authenticated?
    user.present?
  end

  private

  attr_reader :email, :password

  # verify user credentials
  def user
    user = User.find_by(email: email)
    return user if user && user.authenticate(password)
    # raise Authentication error if credentials are invalid
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end