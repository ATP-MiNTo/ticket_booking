class BookingsController < ApplicationController
    def create
        event = Event.find(params[:event_id])
        Event.transaction do
            event.lock!
            if booking_params[:quantity].to_i > event.tickets_available
                render json: { error: "Not enough tickets available" }, status: :unprocessable_entity
                raise ActiveRecord::Rollback
            end

            booking = event.bookings.create!(booking_params)
            render json: booking, status: :created
        end
    end

    private
    def booking_params
        params.require(:booking).permit(:email, :quantity)
    end
end
