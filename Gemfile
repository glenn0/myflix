source 'https://rubygems.org'

gem 'rails', '3.2.11'
gem 'haml-rails'
gem 'bootstrap-sass'
gem 'jquery-rails'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'bootstrap_forms'
gem 'sidekiq'
gem 'unicorn'
gem 'carrierwave'
gem 'mini_magick', '~> 3.5.0'
gem 'fog'
gem 'stripe'
gem 'figaro'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'sqlite3'
  gem 'pry'
  gem 'pry-nav'
  gem 'quiet_assets'
  gem 'letter_opener'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'fabrication'
  gem 'faker'
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'capybara-email'
  gem 'vcr'
  gem 'webmock', '~> 1.11.0'
end

group :production do
  gem 'pg'
end
