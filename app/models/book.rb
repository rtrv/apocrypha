class Book < ApplicationRecord
  include PgSearch
  pg_search_scope :search,
                  against: :name,
                  using: { tsearch: { dictionary: 'english' } }

  validates_presence_of :name, :isbn
  validates_uniqueness_of :isbn, case_sensitive: false
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  # Very simple ISBN format validation
  validates_format_of :isbn, with: /\A\d[\d-]+\d\z/
end
