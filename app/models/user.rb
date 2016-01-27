class User < ActiveRecord::Base
  has_secure_password validations: true
  has_many :articles
  validates :email, :presence => true, :uniqueness => true,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
end
