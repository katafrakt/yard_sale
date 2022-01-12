class Seeds
  class << self
    def call
      collections.each { |col| mongo[col].delete_many }
      RailsEventStoreActiveRecord::Event.delete_all

      uuid1 = SecureRandom.uuid
      bus.call(Sales::Commands::CreateSale.new(sale_id: uuid1, name: "Fantasy Sale",
        description: "I used to be an adventurer, like you. Then I took an arrow to the knee and now I'm selling all that junk that's left from these days. Contact me via Skyrim courier or find me in person in Whiterun (next to the forge)."))
      bus.call(Sales::Commands::CreateOffer.new(
        sale_id: uuid1,
        offer_id: SecureRandom.uuid,
        name: "Rusty sword",
        description: "Only used once to kill some mud crabs. It's rusty now but used to be a fine piece of weapon. Perhaps some blacksmith could put some life into it.",
        price: BigDecimal("22.5"),
        image_url: "https://sagy.vikingove.cz/wp-content/uploads/2018/05/lapland-sword.jpg"
      ))
      bus.call(Sales::Commands::CreateOffer.new(
        sale_id: uuid1,
        offer_id: SecureRandom.uuid,
        name: "Nord Mead",
        description: "The best drink in the whole Tamriel!",
        price: BigDecimal("15"),
        image_url: "https://i.ibb.co/pLzvJQF/Screenshot-2022-01-11-at-00-03-25.png"
      ))
      bus.call(Sales::Commands::CreateOffer.new(
        sale_id: uuid1,
        offer_id: SecureRandom.uuid,
        name: "Gold Claw",
        description: "I don't really even know what this is. I got it from some innkeeper in return of my service, but never found out what it's supposed to do. Looks nice though.",
        price: BigDecimal("300"),
        image_url: "https://i.ibb.co/7C1Vpt4/Screenshot-2022-01-12-at-18-24-59.png"
      ))
      bus.call(Sales::Commands::CreateOffer.new(
        sale_id: uuid1,
        offer_id: SecureRandom.uuid,
        name: "Golden Axe",
        description: "I find piece of weapon. Can be used both for killing things and as a decoration. It has some strange marings on the blade, but I haven't found anyone able to decipher them.",
        price: BigDecimal("1300"),
        image_url: "https://i.ibb.co/QpQ5x9w/270038825-3092557261061956-1234593894203854475-n.jpg"
      ))
      bus.call(Sales::Commands::CreateOffer.new(
        sale_id: uuid1,
        offer_id: SecureRandom.uuid,
        name: "A ring",
        description: "This is just a trinket. If you cast it into the fire, it shows some weird markings, while remaining quite cool. You can use that to impress co-workers or your crush.",
        price: BigDecimal("5"),
        image_url: "https://4.bp.blogspot.com/-Dj2SM7juM1k/UNJAiqY5Z4I/AAAAAAAABEU/UxbTx3d10GY/s320/The+One+Ring.jpg"
      ))
    end

    private

    def mongo = Rails.configuration.mongodb

    def bus = Rails.configuration.command_bus

    def collections = %i[sales offers]
  end
end
