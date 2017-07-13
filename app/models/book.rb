class Book < ApplicationRecord
  include PgSearch
  include Books::Validations
  include Books::ReservationIncludes

  # Full text search
  pg_search_scope :search,
                  against: :name,
                  using: :tsearch

  # Relations
  has_many :reservations
  has_many :users, through: :reservations

  # Scopes
  default_scope { order(created_at: :desc) }
end
