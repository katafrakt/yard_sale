class Sale < Dry::Struct
  attribute :id, Types::UUID.optional
  attribute :name, Types::String.optional.constrained(min_size: 3)
  attribute :description, Types::String.optional
  attribute? :published?, Types::Bool
  attribute? :items_count, Types::Integer
  attribute? :available_items_count, Types::Integer

  def self.build_empty
    new(id: nil, name: nil, description: nil)
  end

  def availability
    p self
    (available_items_count / items_count * 100).round
  end
end
