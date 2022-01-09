module Sales
  module Commands
    class CreateSale < Dry::Struct
      attribute :sale_id, Types::UUID
      attribute :name, Types::String
    end
  end
end