source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '~> 6.0.3', '>= 6.0.3.4'

# Basic
gem 'bootsnap', '>= 1.4.2', require: false
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'pundit'

# Auth
gem 'devise_token_auth', '~> 1.1.4'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  gem 'rspec-rails', '~> 4.0.1'

  # fixtures replacement with a straightforward definition syntax
  gem 'factory_bot_rails'

  # Generate Faker names for tests and seeds
  gem 'faker'

  # Shoulda Matchers provides RSpec- and Minitest-compatible one-liners to test common Rails functionality
  gem 'shoulda-matchers', '~> 4.0'
end

# Cors
gem 'rack-cors', '~> 1.1.1'

# Rendering
gem 'jbuilder', '~> 2.10.1'

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
