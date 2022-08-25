class Reservation < ApplicationRecord
  belongs_to :flat
  belongs_to :user
  validates :check_in, :check_out, presence: true
  validates :check_out, comparison: { greater_than: :check_in }
end
