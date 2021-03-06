source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'haml-rails', '~> 2.0', '>= 2.0.1'
gem 'pg', '~> 1.1'
gem 'bootstrap', '~> 5.1', '>= 5.1.3'
gem 'jquery-rails', '~> 4.4'
gem 'font-awesome-sass', '~> 5.15', '>= 5.15.1'
gem 'simple_form', '~> 5.1'
gem 'faker', '~> 2.19'
gem 'devise', '~> 4.8', '>= 4.8.1'
gem 'friendly_id', '~> 5.4', '>= 5.4.2'
gem 'ransack', '~> 2.5'
gem 'public_activity', '~> 1.6', '>= 1.6.4'
gem 'rolify', '~> 6.0'
gem "pundit"
gem 'exception_notification', '~> 4.5'
gem 'pagy', '~> 5.10', '>= 5.10.1'
gem 'chartkick', '~> 4.1', '>= 4.1.3'
gem 'groupdate', '~> 2.5', '>= 2.5.2'
gem 'ranked-model', '~> 0.4.8'
gem "aws-sdk-s3", require: false
gem 'activestorage-validator'
gem 'omniauth-google-oauth2'
gem 'omniauth-github', github: 'omniauth/omniauth-github', branch: 'master'
gem 'omniauth-rails_csrf_protection'
gem 'omniauth-facebook'
gem 'wicked_pdf'
gem 'wicked' #for multistep forms
gem 'wkhtmltopdf-binary', group: :development
# nested form
gem "cocoon"
# payment
gem 'stripe'
# reduces the size of app in production
gem 'wkhtmltopdf-heroku', group: :production
# Use Puma as the app server
gem 'puma', '~> 5.0'
gem "recaptcha"
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'rails-erd'
  
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]


