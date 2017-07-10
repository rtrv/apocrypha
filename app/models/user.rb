class User < ApplicationRecord
  # Authentication
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Relations
  has_many :reservations
  has_many :books, through: :reservations
end
