source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'dotenv-rails', require: 'dotenv/rails-now'
gem 'rails'
gem 'sqlite3'
gem 'puma', '4.3.6'
# gem 'sass-rails', '~> 5.0'
# gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
# gem 'turbolinks', '~> 5'
# gem 'jbuilder', '~> 2.5'
# gem 'jquery-rails'
gem 'slim-rails'
# gem 'whenever'
gem 'twitter-bootstrap-rails'
gem 'uart'
gem 'rpi_gpio', github: 'ClockVapor/rpi_gpio' if ENV['RPI'] == '1'
gem 'spi'
gem 'i2c'
gem 'rtsp'

group :development do
  gem 'listen'
  gem 'byebug'
  gem 'capistrano',            require: false
  gem 'capistrano-bundler',    require: false
  gem 'capistrano-nvm',        require: false
  gem 'capistrano-rails',      require: false
  gem 'capistrano-rvm',        require: false
  gem 'capistrano-yarn',       require: false
  gem 'capistrano3-puma', '4.0.0', require: false
  gem 'ed25519'
  gem 'bcrypt_pbkdf'
end
