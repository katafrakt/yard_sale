module Sales
  module Handlers
    class SaleCreation
      AlreadyCreated = Class.new(StandardError)

      def initialize(event_store)
        @event_store = event_store
      end

      def call(command)
        stream = "Sales::Sale$#{command.sale_id}"
        events = @event_store.read.stream(stream).to_a
        raise AlreadyCreated unless events.empty?

        event = SaleCreated.new(
          data: {
            sale_id: command.sale_id,
            name: command.name
          }
        )
        
        @event_store.publish(event, stream_name: stream)
      end
    end
  end
end