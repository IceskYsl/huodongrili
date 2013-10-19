Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "480641976417.apps.googleusercontent.com", "xvcihy6jq53tcg5uosPuqze9"
  # provider :google_oauth2, Setting.omniauth_google_oauth2['GOOGLE_KEY'], Setting.omniauth_google_oauth2['GOOGLE_SECRET']  
end