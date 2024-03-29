Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :openid, :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
end