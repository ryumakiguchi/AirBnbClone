class Flat < ApplicationRecord
  belongs_to :user
  has_one :reservation
  has_one_attached :photo
end
