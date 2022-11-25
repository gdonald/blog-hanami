# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.1.3'

gem 'dry-types', '~> 1.0', '>= 1.6.1'
gem 'hanami', '~> 2.0'
gem 'hanami-controller', '~> 2.0'
gem 'hanami-router', '~> 2.0'
gem 'hanami-validations', '~> 2.0'
gem 'pg'
gem 'puma'
gem 'rake'
gem 'rom', '~> 5.3'
gem 'rom-sql', '~> 3.6'

group :development, :test do
  gem 'dotenv'
  gem 'rubocop', '~> 1.39.0', require: false
  gem 'rubocop-rake'
  gem 'rubocop-rspec'
end

group :cli, :development do
  gem 'hanami-reloader'
end

group :cli, :development, :test do
  gem 'hanami-rspec'
end

group :development do
  gem 'guard-puma', '~> 0.8'
end

group :test do
  gem 'database_cleaner-sequel'
  gem 'rack-test'
end
