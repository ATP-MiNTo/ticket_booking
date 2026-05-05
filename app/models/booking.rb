class Booking < ApplicationRecord
  belongs_to :event

  validates :email, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  validates :check_in_code, presence: true, uniqueness: true

  before_create :generate_check_in_code

  private

  def generate_check_in_code
    loop do
      self.check_in_code = SecureRandom.alphanumeric(6).upcase
      break unless Booking.exists?(check_in_code:)
    end
  end
end
