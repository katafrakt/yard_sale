class OfferRepository
  def insert_offer(data)
    id = data.delete(:id)
    price = data.delete(:price)
    collection.insert_one(data.merge(_id: id, price: price.to_f))
  end

  def by_sale(sale_id, opts = {})
    limit = opts.fetch(:limit, 8)
    offset = opts.fetch(:offset, 0)
    collection.find(sale_id:).skip(offset).limit(limit).to_a.map do |offer|
      doc_to_entity(offer)
    end
  end

  private

  def mongo = Rails.configuration.mongodb

  def collection = mongo[:offers]

  def doc_to_entity(doc)
    Offer.new(
      id: doc[:_id],
      name: doc[:name],
      description: doc[:description],
      price: doc[:price].to_d,
      state: doc[:state].to_sym,
      image_url: doc[:image_url]
    )
  end
end
