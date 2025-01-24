source "https://rubygems.org"

ruby "3.0.2"

gem "rails", "~> 7.1.5"

gem "sprockets-rails"

gem 'pg'

gem "puma", ">= 5.0"

gem "importmap-rails"

gem "turbo-rails"

gem "stimulus-rails"

gem "jbuilder"

gem 'active_interaction'

gem "tzinfo-data", platforms: %i[ mswin mswin64 mingw x64_mingw jruby ]

gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri mswin mswin64 mingw x64_mingw ]
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'dotenv-rails'
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem 'factory_bot_rails'
  gem 'simplecov'
end
