module Books
  module ReservationIncludes
    extend ActiveSupport::Concern

    class_methods do
      # Include reservation_count and free_count to AR relation
      def include_counts
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

      def include_user_reservations(user)
        unless user.is_a? User
          raise 'Parameter `user` should be an instance of User class insted ' \
                "of #{user.class.name}"
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
          %(books.*, b.id AS user_reservation_id)
        )
      end
    end
  end
end
