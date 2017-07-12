module Reservations
  class Creator < Base::Creator
    def create
      super do
        self.result = Reservation.create!(book: @book, user: @user)
      end
    end
  end
end
