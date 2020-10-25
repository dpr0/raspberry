# frozen_string_literal: true

require 'uart'
require 'byebug'
require 'json'
require 'ya_gpio'
require_relative 'mhz19b'
require_relative 'raspberry'

use Rack::Reloader
run Raspberry.new
