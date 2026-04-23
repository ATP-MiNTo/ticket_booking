class Booking < ApplicationRecord
  belongs_to :event
  
  validates :email, presence: true
  validates :quantity, numericality: { greater_than: 0 }
end
