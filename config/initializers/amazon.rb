require 'amazon/ecs'
Amazon::Ecs.configure do |options|
  options[:aWS_access_key_id] = "***REMOVED***"
  options[:aWS_secret_key] = "***REMOVED***"
end

