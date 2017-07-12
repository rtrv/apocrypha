class ReservationsController < ApplicationController
  def create
    creator_instance = Reservations::Creator.new(
      book: Book.find(params[:book]), user: User.find(params[:user])
    )
    creator_instance.create

    if creator_instance.status == :success
      redirect_to :back
    elsif creator_instance.status == :error
      redirect_to :back
    end
  end

  def destroy
    destroyer_instance = Reservations::Destroyer.new(
      reservation: Reservation.find(params[:id])
    )
    destroyer_instance.destroy

    if destroyer_instance.status == :success
      redirect_to :back
    elsif destroyer_instance.status == :error
      redirect_to :back
    end
  end
end
