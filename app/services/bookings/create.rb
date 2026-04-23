module Bookings
  class Create
    Result = Struct.new(:success, :booking, :error, :status, keyword_init: true) do
      def success?
        success
      end
    end

    def self.call(event_id:, booking_params:)
      new(event_id:, booking_params:).call
    end

    def initialize(event_id:, booking_params:)
      @event_id = event_id
      @booking_params = booking_params
    end

    def call
      event = Event.find(event_id)
      booking = nil
      error = nil

      event.with_lock do
        booking = event.bookings.new(booking_params)

        unless booking.valid?
          error = booking.errors.full_messages.to_sentence
          raise ActiveRecord::Rollback
        end

        if booking.quantity > event.tickets_available
          error = "Not enough tickets available"
          raise ActiveRecord::Rollback
        end

        booking.save!
      end

      if booking&.persisted?
        Result.new(success: true, booking: booking, status: :created)
      else
        Result.new(success: false, error: error || "Unable to create booking", status: :unprocessable_entity)
      end
    rescue ActiveRecord::RecordNotFound
      Result.new(success: false, error: "Event not found", status: :not_found)
    end

    private

    attr_reader :event_id, :booking_params
  end
end
