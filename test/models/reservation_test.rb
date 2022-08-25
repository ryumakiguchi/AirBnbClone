require "test_helper"

class ReservationTest < ActiveSupport::TestCase
  test "invalid if checkin date is before today" do
    user = users(:mew_two)
    flat = flats(:veracruz)
    date_today = DateTime.now
    reservation = Reservation.new(flat: flat, user: user, check_in: date_today - 1, check_out: date_today + 4)
    refute reservation.valid?
  end

  test "invalid if checkout date is earlier than checkin date" do
    user = users(:mew_two)
    flat = flats(:veracruz)
    date_today = DateTime.now
    date_yesterday = date_today - 1
    reservation = Reservation.new(flat: flat, user: user, check_in: date_today, check_out: date_yesterday)
    refute reservation.valid?
  end

  test "invalid if checkout date is same date as checkin date" do
    user = users(:mew_two)
    flat = flats(:veracruz)
    date_today = DateTime.now
    reservation = Reservation.new(flat: flat, user: user, check_in: date_today, check_out: date_today)
    refute reservation.valid?
  end
end
