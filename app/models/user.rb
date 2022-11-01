class User < ApplicationRecord
  has_secure_password
  has_many :houses, foreign_key: 'user_id'
  has_many :reservations, foreign_key: 'user_id'
  # mount_uploader :avatar, AvatarUploader
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
end
