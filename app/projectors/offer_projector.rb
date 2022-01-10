class OfferProjector
  def subscribe(event_store)
    event_store.subscribe(to: [OfferCreated]) { |event| insert_offer(event) }
  end

  private

  def insert_offer(event)
    data = event.data
    OfferRepository.new.insert_offer(
      id: data[:offer_id],
      sale_id: data[:sale_id],
      price: data[:price],
      name: data[:name],
      description: data[:description],
      image_url: data[:image_url],
      state: "available"
    )
  end
end
