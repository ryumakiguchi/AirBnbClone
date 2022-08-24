class Reservation < ApplicationRecord
  belongs_to :flat
  belongs_to :user
  validates :check_in, :check_out, presence: true
end
