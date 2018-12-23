require 'rpi_gpio'
RPi::GPIO.set_numbering(:bcm) if ENV['RPI'] == '1'
