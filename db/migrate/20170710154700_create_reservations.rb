class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.belongs_to :book, null: false
      t.belongs_to :user, null: false

      # Two double field indexes to have fast access from both sides
      t.index [:user_id, :book_id], unique: true
      t.index [:book_id, :user_id]

      t.timestamps
    end
  end
end
