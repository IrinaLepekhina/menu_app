class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  # validates :password_digest, presence: true
  # validates :password, confirmation: true

  validates :nickname, exclusion: { in: %w(admin administrator),
    message: "is reserved" }
  validates :nickname, format: { with: /\A[a-zA-Z0-9]+\z/ ,
    message: "only leters and numbers" }

  has_secure_password

  # model mailer
  # need migration on User#send_confirmations, true

  # after_create :send_confirmation_email, if: -> { self.user send_confirmations }
  # private
  # def send_confirmation_email
  #   UserMailer.user_created(User.last.email, User.last.id).deliver_now
  # end
  
end
