# frozen_string_literal: true

# rackup -s puma --host 0.0.0.0 config.ru # default port: 9292

require 'uart'
require 'json'
require 'ya_gpio'
require 'i2c'
require 'i2c/bme280'
require_relative 'mhz19b'
require_relative 'raspberry'

use Rack::Reloader
run Raspberry.new
