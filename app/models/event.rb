class Event < ApplicationRecord
    has_many :bookings

    def tickets_available
        capacity - bookings.sum(:quantity)
    end
end
