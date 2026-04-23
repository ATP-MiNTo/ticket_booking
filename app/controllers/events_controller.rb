class EventsController < ApplicationController
    def index
        events = Event.all

        render json: events.map { |event|
        {
            id: event.id,
            name: event.name,
            date: event.date,
            capacity: event.capacity,
            tickets_available: event.tickets_available
        }
        }
    end
end
