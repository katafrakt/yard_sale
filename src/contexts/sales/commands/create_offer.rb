module Sales
  module Commands
    class CreateOffer < Dry::Struct
      attribute :offer_id, Types::UUID
      attribute :sale_id, Types::UUID
      attribute :name, Types::String
      attribute :description, Types::String
      attribute :price, Types::Decimal
      attribute :image_url, Types::String
    end
  end
end
