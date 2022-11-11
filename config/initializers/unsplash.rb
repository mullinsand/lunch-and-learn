Unsplash.configure do |config|
  config.application_access_key = ENV['UNSPLASH_KEY']
  config.application_secret = ENV['UNSPLASH_SECRET']
  config.application_redirect_uri = "https://localhost:3000/oauth/callback"
  config.utm_source = "lunch_and_learn_app"

  # optional:
  # config.logger = MyCustomLogger.new
end