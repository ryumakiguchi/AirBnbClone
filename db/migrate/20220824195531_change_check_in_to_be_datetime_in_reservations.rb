class ChangeCheckInToBeDatetimeInReservations < ActiveRecord::Migration[7.0]
  def change
    change_column(:reservations, :check_in, :datetime)
    change_column(:reservations, :check_out, :datetime)
  end
end

