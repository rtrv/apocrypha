module Reservations
  module Validations
    extend ActiveSupport::Concern

    included do
      validates_uniqueness_of :book, scope: :user_id
      validate :book_availability

      private

      def book_availability
        if book.reservations.size >= book.quantity
          raise('There is no free book!')
        end
      end
    end
  end
end
