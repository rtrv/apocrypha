module Reservations
  class Destroyer < Base::Destroyer
    def destroy
      super do
        @reservation.destroy
      end
    end
  end
end
