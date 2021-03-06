require "rails_event_store"
require "aggregate_root"
require "arkency/command_bus"

module YAMLProxy
  def self.dump(value) = YAML.dump(value)

  def self.load(serialized) = YAML.unsafe_load(serialized)
end

Rails.configuration.to_prepare do
  event_store = RailsEventStore::Client.new(
    repository: RailsEventStoreActiveRecord::EventRepository.new(serializer: YAMLProxy)
  )

  Rails.configuration.event_store = event_store
  Rails.configuration.command_bus = Arkency::CommandBus.new

  AggregateRoot.configure do |config|
    config.default_event_store = Rails.configuration.event_store
  end

  # Subscribe event handlers below
  Rails.configuration.event_store.tap do |store|
    # store.subscribe(InvoiceReadModel.new, to: [InvoicePrinted])
    # store.subscribe(lambda { |event| SendOrderConfirmation.new.call(event) }, to: [OrderSubmitted])
    # store.subscribe_to_all_events(lambda { |event| Rails.logger.info(event.event_type) })

    store.subscribe_to_all_events(RailsEventStore::LinkByEventType.new)
    store.subscribe_to_all_events(RailsEventStore::LinkByCorrelationId.new)
    store.subscribe_to_all_events(RailsEventStore::LinkByCausationId.new)
  end

  # Register command handlers below
  Rails.configuration.command_bus.tap do |bus|
    #   bus.register(PrintInvoice, Invoicing::OnPrint.new)
    #   bus.register(SubmitOrder,  ->(cmd) { Ordering::OnSubmitOrder.new.call(cmd) })
    bus.register(Sales::Commands::CreateSale, Sales::Handlers::SaleCreation.new(event_store))
    bus.register(Sales::Commands::CreateOffer, Sales::Handlers::OfferCreation.new(event_store))
    bus.register(Sales::Commands::ReserveOffer, Sales::Handlers::OfferReservation.new(event_store))
  end

  [SaleProjector, OfferProjector].each do |projector|
    projector.new.subscribe(event_store)
  end
end
