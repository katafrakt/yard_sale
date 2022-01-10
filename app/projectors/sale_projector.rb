class SaleProjector
  def subscribe(event_store)
    event_store.subscribe(to: [SaleCreated]) { |event| insert_sale(event) }
    event_store.subscribe(to: [OfferCreated]) { |event| increment_items_count(event) }
  end

  private

  def insert_sale(event)
    data = event.data
    SaleRepository.new.insert_sale(id: data[:sale_id], name: data[:name], description: data[:description])
  end

  def increment_items_count(event)
    SaleRepository.new.increment_items_count(event.data[:sale_id])
  end
end