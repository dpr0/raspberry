module ApplicationHelper
  def check_pin?(pin)
    RPi::GPIO.high?(pin[:num]) if ENV['RPI'] == '1' && pin[:num].is_a?(Integer)
  end
end
