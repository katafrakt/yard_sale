class Seeds
  class << self
    def call
      collections.each { |col| mongo[col].delete_many }
      RailsEventStoreActiveRecord::Event.delete_all

      content = File.read(Rails.root.join("lib", "seeds", "seeds.sdl"))
      seed = SDLang.parse(content)
      seed.find_all(:sale).each do |sale|
        sale_uuid = SecureRandom.uuid
        description = sale.children.find(:description)&.value

        bus.call(Sales::Commands::CreateSale.new(
          sale_id: sale_uuid,
          name: sale.value,
          description: description
        ))

        sale.children.find_all(:offer).each do |offer|
          offer_uuid = SecureRandom.uuid
          description = offer.children.find(:description)&.value

          bus.call(Sales::Commands::CreateOffer.new(
            sale_id: sale_uuid,
            offer_id: offer_uuid,
            name: offer.value,
            description: description,
            price: BigDecimal(offer.attribute(:price)),
            image_url: offer.attribute(:image_url)
          ))

          if offer.attribute(:state) == "reserved"
            bus.call(
              Sales::Commands::ReserveOffer.new(
                offer_id: offer_uuid, sale_id: sale_uuid
            ))
          end
        end
      end
    end

    private

    def mongo = Rails.configuration.mongodb

    def bus = Rails.configuration.command_bus

    def collections = %i[sales offers]
  end
end
