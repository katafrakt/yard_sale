require "mongo"

client = Mongo::Client.new(ENV["MONGO_ATLAS_CONNECTION_URL"])

Rails.configuration.to_prepare do
  Rails.configuration.mongodb = client
end
