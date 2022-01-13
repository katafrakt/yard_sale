module Sales
  module Commands
    class ReserveOffer < Dry::Struct
      attribute :offer_id, Types::UUID
      attribute :sale_id, Types::UUID
    end
  end
end
