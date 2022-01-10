module Sales
  module Handlers
    class OfferCreation
      def initialize(event_store)
        @event_store = event_store
      end

      def call(command)
        stream = "Sales::Sale$#{command.sale_id}"
        event = OfferCreated.new(
          data: {
            sale_id: command.sale_id,
            offer_id: command.offer_id,
            name: command.name,
            description: command.description,
            price: command.price,
            image_url: command.image_url
          }
        )

        @event_store.publish(event, stream_name: stream)
      end
    end
  end
end
