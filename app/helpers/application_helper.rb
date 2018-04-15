module ApplicationHelper
  def check_pin?(pin)
    return if ENV['RPI'] == '0' || pin.is_a?(String)
    RPi::GPIO.setup pin, as: :input
    RPi::GPIO.high?(pin)
  end
end
