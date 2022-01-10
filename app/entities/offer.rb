class Offer < Dry::Struct
  attribute :id, Types::UUID.optional
  attribute :name, Types::String.optional
  attribute? :description, Types::String
  attribute :state, Types::Symbol.enum(:available, :reserved, :sold)
  attribute :price, Types::Decimal.optional
  attribute? :image_url, Types::String.optional
end