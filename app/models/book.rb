class Book < ApplicationRecord
  include PgSearch

  # Full text search
  pg_search_scope :search,
                  against: :name,
                  using: :tsearch

  # Relations
  has_many :reservations, before_add: :validate_availability
  has_many :users, through: :reservations

  # Validations
  validates_presence_of :name, :isbn
  validates_uniqueness_of :isbn, case_sensitive: false
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  # Very simple ISBN format validation
  validates_format_of :isbn, with: /\A\d[\d-]+\d\z/

  # Scopes
  default_scope { order(created_at: :desc) }

  # Include reservation_count and free_count to AR relation
  def self.include_counts
    joins(
      %{
        LEFT OUTER JOIN (
          SELECT c.book_id, COUNT(*) reservation_count
          FROM   reservations c
          GROUP BY c.book_id
        ) a ON a.book_id = books.id
      }
    ).select(
      %{
        books.*, COALESCE(a.reservation_count, 0) AS reservation_count,
        (books.quantity - COALESCE(a.reservation_count, 0)) AS free_count,
        Cast(
          Cast(
            books.quantity - COALESCE(a.reservation_count, 0) as integer
          ) as boolean
        ) AS is_available
      }
    )
  end

  # TODO
  def self.include_user_reservations(user)
    unless user.is_a? User
      raise 'Parameter `user` should be an instance of User class insted of ' \
            "#{user.class.name}"
    end

    joins(
      %{
        LEFT OUTER JOIN (
          SELECT r.book_id, r.id
          FROM   reservations r
          WHERE r.user_id = #{user.id}
        ) b ON b.book_id = books.id
      }
    ).select(
      %{
        books.*, b.id AS user_reservation_id
      }
    )
  end

  private

  def validate_availability(_record)
    raise('There is no free book!') if reservations.size >= quantity
  end
end
