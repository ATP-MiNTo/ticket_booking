class AddCheckinToBookings < ActiveRecord::Migration[8.1]
  def change
    add_column :bookings, :check_in_code, :string, null: false, default: ""
    add_column :bookings, :checked_in_at, :datetime

    add_index :bookings, :check_in_code, unique: true
  end
end
