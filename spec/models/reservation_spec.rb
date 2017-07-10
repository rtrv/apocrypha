require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:reservation) do
    Reservation.new(
      book: build(:book),
      user: build(:user)
    )
  end

  it 'sould have unique book-user pairs' do
    expect(reservation).to validate_uniqueness_of(:book).scoped_to(:user_id)
  end

  # TODO
  it 'should not be created if there is no free book'
end
