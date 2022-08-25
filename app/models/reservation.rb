class Reservation < ApplicationRecord
  belongs_to :flat
  belongs_to :user
  validates :check_in, presence: true, comparison: { greater_than: DateTime.now }
  validates :check_out, presence: true, comparison: { greater_than: :check_in }
end
