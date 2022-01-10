require "rails_helper"

RSpec.describe Sales::Commands::CreateSale do
  let(:sale_id) { SecureRandom.uuid }
  let(:command_bus) { Rails.configuration.command_bus }
  let(:event_store) { Rails.configuration.event_store }
  let(:stream) { "Sales::Sale$#{sale_id}" }

  describe "with command bus" do
    it "publishes event" do
      cmd = described_class.new(sale_id:, name: "test", description: "test sale")
      command_bus.call(cmd)
      events = event_store.read.stream(stream).to_a
      expect(events.length).to eq(1)
      expect(events.first).to be_kind_of(SaleCreated)
      expect(events.first.data).to eq(sale_id:, name: "test", description: "test sale")
    end

    it "raises exception when sale already created" do
      cmd = described_class.new(sale_id:, name: "test", description: "test sale")
      command_bus.call(cmd)
      expect { command_bus.call(cmd) }.to raise_exception(Sales::Handlers::SaleCreation::AlreadyCreated)
    end
  end
end
