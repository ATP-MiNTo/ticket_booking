module Bookings
  class Checkin
    Result = Struct.new(:success, :booking, :error, :status, keyword_init: true) do
      def success?
        success
      end
    end

    def self.call(check_in_code:)
      new(check_in_code:).call
    end

    def initialize(check_in_code:)
      @check_in_code = check_in_code.upcase
    end

    def call
      booking = Booking.find_by(check_in_code: @check_in_code)

      unless booking
        return Result.new(success: false, error: "Invalid check-in code", status: :not_found)
      end

      if booking.checked_in_at.present?
        return Result.new(success: false, error: "Booking already checked in", status: :unprocessable_entity)
      end

      booking.update!(checked_in_at: Time.current)
      Result.new(success: true, booking: booking, status: :ok)
    rescue => e
      Result.new(success: false, error: e.message, status: :internal_server_error)
    end

    private

    attr_reader :check_in_code
  end
end
