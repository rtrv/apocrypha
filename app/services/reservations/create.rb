module Reservations
  class Create < Base::Create
    def perform
      super do
        self.result = Reservation.create!(book: @book, user: @user)
      end
    end
  end
end
