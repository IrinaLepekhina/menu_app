class User < ApplicationRecord
  # validates :password, confirmation: true

  validates_presence_of :email, :nickname, :password_digest
  validates_uniqueness_of :email, :nickname
  validates_confirmation_of :password

  validates :nickname, exclusion: { in: %w(admin administrator),
    message: "is reserved" }
  validates :nickname, format: { with: /\A[a-zA-Z0-9]+\z/ ,
    message: "only leters and numbers" }

  # encrypt password
  has_secure_password

  def self.authenticate(email, password)
    user = find_by_email(email)
    user if user && user.authenticate(password)
  end

  # model mailer
  # need migration on User#send_confirmations, true

  # after_create :send_confirmation_email, if: -> { self.user send_confirmations }
  # private
  # def send_confirmation_email
  #   UserMailer.user_created(User.last.email, User.last.id).deliver_now
  # end
  
end
