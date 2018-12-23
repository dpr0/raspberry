source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'dotenv-rails'
gem 'rails', '~> 5.1.6'
gem 'sqlite3'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'slim-rails'
gem 'whenever'
gem 'twitter-bootstrap-rails'
gem 'uart'
gem 'rpi_gpio', github: 'ClockVapor/rpi_gpio' if ENV['RPI'] == '1'
gem 'spi'
gem 'i2c'
gem 'rtsp'
gem 'unicorn'

group :development do
  gem 'byebug'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'capistrano',          require: false
  gem 'capistrano-bundler',  require: false
  gem 'capistrano-rails',    require: false
  gem 'capistrano-rvm',      require: false
  gem 'capistrano3-unicorn', require: false
  gem 'capistrano-local-precompile', '~> 1.1.1', require: false
end
