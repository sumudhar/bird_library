source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
gem 'mongoid', '~> 5.1', '>= 5.1.4'
gem 'mongoid-tree', '~> 2.1'
gem 'bson'
gem 'bson_ext'
gem 'mongo'
gem 'mongo_ext'
gem 'mongoid_paranoia'
gem 'pry'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'responders', '~> 2.0'
gem "roar-rails"
gem 'multi_json'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# Test-only
group :development, :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'foreman'
  gem 'rack-test'
  # database_cleaner 1.4 has a breaking change."
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'capybara'
end

