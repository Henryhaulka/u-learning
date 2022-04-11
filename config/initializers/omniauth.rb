Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '738122909123-0mgcb3enabqt2iosn9pl0sej792selb3.apps.googleusercontent.com', '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'
end
OmniAuth.config.allowed_request_methods = %i[get]