class ReservationsController < ApplicationController
  private

  def create_params
    { book: Book.find(params[:book]), user: User.find(params[:user]) }
  end
end
