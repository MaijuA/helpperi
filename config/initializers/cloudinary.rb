Cloudinary.config do |config|
  config.cloud_name = "helpperi"
  config.api_key = ENV['CLOUDINARY_API_KEY']
  config.api_secret = ENV['CLOUDINARY_SECRET_KEY']
  config.cdn_subdomain = true
end