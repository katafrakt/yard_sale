module Sales
  module Handlers
    class OfferReservation
      def initialize(event_store)
        @event_store = event_store
      end

      def call(command)
        stream = "Sales::Sale$#{command.sale_id}"
        event = OfferReserved.new(
          data: {
            offer_id: command.offer_id,
            sale_id: command.sale_id
          }
        )

        @event_store.publish(event, stream_name: stream)
      end
    end
  end
end
