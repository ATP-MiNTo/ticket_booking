class BookingsController < ApplicationController
    def create
        result = Bookings::Create.call(event_id: params[:event_id], booking_params: booking_params)

        if result.success?
            render json: result.booking, status: result.status
        else
            render json: { error: result.error }, status: result.status
        end
    end

    def check_in
        result = Bookings::Checkin.call(check_in_code: params[:check_in_code])

        if result.success?
            render json: result.booking, status: result.status
        else
            render json: { error: result.error }, status: result.status
        end
    end

    private
    def booking_params
        params.require(:booking).permit(:email, :quantity)
    end
end
