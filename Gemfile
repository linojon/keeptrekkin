source 'https://rubygems.org'
ruby '2.1.1'

gem 'rails', '4.1.1'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'haml'
gem 'simple_form', '~> 3.1.0.rc1', github: 'plataformatec/simple_form', branch: 'master'
gem 'bootstrap-sass', '~> 3.1.1'
gem 'redcarpet'
gem 'select2-rails'
gem 'bootstrap-datepicker-rails'
gem 'easy_as_pie'

gem 'pundit'
gem 'decent_exposure'
gem 'omniauth'
gem 'omniauth-facebook', '1.4.0'
gem 'amatch'
gem 'figaro'

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'capybara-webkit'
  gem 'persistent_selenium'
  gem 'database_cleaner'
  
  gem 'shoulda-matchers', require: false
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'launchy'
  gem 'spring-commands-rspec'
  gem 'guard-rspec'

  gem 'better_errors'
  gem 'binding_of_caller'
  
  gem 'byebug'
  gem 'pry'
  gem 'pry-rails'
  #gem 'pry-byebug'
  # gem 'awesome_print'
  # gem 'annotate'
  gem 'quiet_assets'
end

group :development, :test, :darwin do # and run heroku config:add BUNDLE_WITHOUT="development test darwin"
  gem 'rb-fsevent' # osx file event api
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

