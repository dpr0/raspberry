if ENV['RPI'] == 1
  RPi::GPIO.set_numbering :bcm
end
