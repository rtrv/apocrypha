class Reservation < ApplicationRecord
  include Reservations::Validations

  # Relations
  belongs_to :book
  belongs_to :user
end
