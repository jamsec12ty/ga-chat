class User < ApplicationRecord
  has_many :messages
  has_and_belongs_to_many :friends

  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
