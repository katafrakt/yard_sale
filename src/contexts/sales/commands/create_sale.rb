module Sales
  module Commands
    class CreateSale < Dry::Struct
      attribute :sale_id, Types::UUID
      attribute :name, Types::String
      attribute :description, Types::String
    end
  end
end
