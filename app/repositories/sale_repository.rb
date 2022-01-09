class SaleRepository
  def insert_sale(id:, name:, description:)
    collection.insert_one({_id: id, name: name, description: description, published: false, items_count: 0})
  end

  def get(id)
    doc = collection.find(_id: id).to_a.first
    Sale.new(id: id, name: doc[:name], description: doc[:description], published?: doc[:published], items_count: doc[:items_count])
  end

  def all = collection.find.to_a

  def mongo = Rails.configuration.mongodb
  def collection = mongo[:sales]
end