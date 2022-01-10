class Seeds
  class << self
    def call
      collections.each { |col| mongo[col].drop }
      RailsEventStoreActiveRecord::Event.delete_all

      uuid1 = SecureRandom.uuid
      bus.(Sales::Commands::CreateSale.new(sale_id: uuid1, name: "Fantasy Sale", description: "I used to be an adventurer, like you. Then I took an arrow to the knee and now I'm selling all that junk that's left from those days."))
      bus.(Sales::Commands::CreateOffer.new(
        sale_id: uuid1,
        offer_id: SecureRandom.uuid,
        name: "Rusty sword",
        description: "Only used once to kill some mud crabs.",
        price: 225.to_d,
        image_url: "https://sagy.vikingove.cz/wp-content/uploads/2018/05/lapland-sword.jpg"
      ))
      bus.(Sales::Commands::CreateOffer.new(
        sale_id: uuid1,
        offer_id: SecureRandom.uuid,
        name: "Nord Mead",
        description: "The best drink in the whome Tamriel!",
        price: 15.to_d,
        image_url: "https://i.ibb.co/pLzvJQF/Screenshot-2022-01-11-at-00-03-25.png"
      ))
    end

    private

    def mongo = Rails.configuration.mongodb
    def bus = Rails.configuration.command_bus
    def collections = %i[sales offers]
  end
end