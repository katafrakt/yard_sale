class SaleProjector
  def subscribe(event_store)
    event_store.subscribe(to: [SaleCreated]) { |event| insert_sale(event) }
  end

  private

  def insert_sale(event)
    data = event.data
    SaleRepository.new.insert_sale(id: data[:sale_id], name: data[:name], description: data[:description])
  end
end