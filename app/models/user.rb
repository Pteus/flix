class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A\S+@\S+\Z/ },
            uniqueness: { case_sensitive: false }
end
