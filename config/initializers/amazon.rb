require 'amazon/ecs'
Amazon::Ecs.configure do |options|
  options[:aWS_access_key_id] = ENV['aWS_access_key_id']
  options[:aWS_secret_key] = ENV['aWS_secret_key']
end

