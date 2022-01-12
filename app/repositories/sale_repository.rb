class SaleRepository
  def insert_sale(id:, name:, description:)
    collection.insert_one({_id: id, name:, description:, published: false, items_count: 0, available_items_count: 0})
  end

  def get(id)
    doc = collection.find(_id: id).to_a.first
    doc_to_entity(doc)
  end

  def by_ids(ids)
    collection.find(_id: {"$in" => ids}).to_a.map { |x| doc_to_entity(x) }
  end

  def all = collection.find.to_a.map { |x| doc_to_entity(x) }

  def increment_items_count(sale_id)
    collection.find(_id: sale_id).update_one("$inc" => {items_count: 1})
  end

  def increment_available_items_count(sale_id)
    collection.find(_id: sale_id).update_one("$inc" => {available_items_count: 1})
  end

  private

  def mongo = Rails.configuration.mongodb

  def collection = mongo[:sales]

  def doc_to_entity(doc)
    Sale.new(id: doc[:_id], name: doc[:name], description: doc[:description], published?: doc[:published],
      items_count: doc[:items_count], available_items_count: doc[:available_items_count])
  end
end
