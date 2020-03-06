$redis = Redis.new

url = ENV["redis-16416.c12.us-east-1-4.ec2.cloud.redislabs.com:16416"]

if url
  Sidekiq.configure_server do |config|
    config.redis = { url: url }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: url }
  end
  $redis = Redis.new(:url => url)
end
