class Sale < Dry::Struct
  attribute :id, Types::UUID.optional
  attribute :name, Types::String
  attribute :description, Types::String.optional
  attribute? :published?, Types::Bool
  attribute? :items_count, Types::Integer

  def self.build_empty
    new(id: nil, name: "", description: nil)
  end
end