class BookingsController < ApplicationController
    def create
        event = Event.find(params[:event_id])
        booking = event.bookings.new(booking_params)
        if booking.quantity > event.tickets_available
            render json: { error: "Not enough tickets available" }, status: :unprocessable_entity
            return
        end
        booking.save!
        render json: booking, status: :created
    end

    private
    def booking_params
        params.require(:booking).permit(:email, :quantity)
    end
end
