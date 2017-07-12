module Reservations
  class Destroy < Base::Destroy
    def perform
      super do
        Reservation.find(@id).destroy
      end
    end
  end
end
