class Reservation < ApplicationRecord
  # Relations
  belongs_to :book
  belongs_to :user

  # Validations
  validates_uniqueness_of :book, scope: :user_id
end
