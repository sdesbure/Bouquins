require 'amazon/ecs'
Amazon::Ecs.configure do |options|
  options[:AWS_access_key_id] = ENV['aWS_access_key_id']
  options[:AWS_secret_key] = ENV['aWS_secret_key']
  options[:associate_tag] = ENV['AssociateTag']
end

