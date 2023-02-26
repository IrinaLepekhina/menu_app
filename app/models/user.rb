class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  # validates :password_digest, presence: true

  # validates :password, confirmation: true
  validates :nickname, exclusion: { in: %w(admin administrator),
    message: "is reserved" }
  validates :nickname, format: { with: /\A[a-zA-Z0-9]+\z/ ,
    message: "only leters and numbers" }

  has_secure_password
end
