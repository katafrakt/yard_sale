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

  def search(query)
    offers = collection.aggregate([
      {
        "$search" => {
          "index" => "offers-search",
          "text" => {
            "query" => query,
            "path" => ["name", "description"],
            "fuzzy" => {"maxEdits" => 1}
          }
        }

      },
      {
        "$limit" => 8
      }
    ]).to_a

    sale_ids = offers.map { |o| o[:sale_id] }.uniq
    sales = SaleRepository.new.by_ids(sale_ids)

    offers.map { |o| doc_to_entity(o, sales:) }
  end

  private

  def mongo = Rails.configuration.mongodb

  def collection = mongo[:offers]

  def doc_to_entity(doc, opts = {})
    params = {
      id: doc[:_id],
      name: doc[:name],
      description: doc[:description],
      price: doc[:price].to_d,
      state: doc[:state].to_sym,
      image_url: doc[:image_url]
    }

    if opts[:sales]
      sale = opts[:sales].detect { |s| s.id == doc[:sale_id] }
      params[:sale] = sale
    end

    Offer.new(params)
  end
end
