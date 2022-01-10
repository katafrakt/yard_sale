require "mongo"

client = Mongo::Client.new(["localhost"], database: "yard_sale_dev")

Rails.configuration.to_prepare do
  Rails.configuration.mongodb = client
end
