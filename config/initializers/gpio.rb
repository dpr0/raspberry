if ENV['RPI'] == '1'
  require 'rpi_gpio'
  RPi::GPIO.set_numbering(:bcm)
end
