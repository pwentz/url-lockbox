class User < ApplicationRecord
  has_secure_password
  validates :email_address, uniqueness: true, presence: true
  validates_confirmation_of :password, message: 'Passwords do not match'

  has_many :links
end
