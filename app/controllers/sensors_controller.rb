class SensorsController < ApplicationController
  def index
    @sensor = Sensor.check
    respond_to do |format|
      format.html
      format.json { render json: @sensor }
    end
  end

  def set_gpio
    return if ENV['RPI'] == 0
    pins = Gpio::GPIO.flatten.map { |x| x[:num] if x[:num].is_a?(Integer) }.compact.sort
    set_pins = params[:gpio_pins].map(&:to_i).sort
    pins.each do |pin|
      RPi::GPIO.setup(pin, as: :output) if (set_pins.include?(pin) && RPi::GPIO.low?(pin)) || (!set_pins.include?(pin) && RPi::GPIO.high?(pin))
      RPi::GPIO.set_high(pin) if set_pins.include?(pin) && RPi::GPIO.low?(pin)
      RPi::GPIO.set_low(pin) if !set_pins.include?(pin) && RPi::GPIO.high?(pin)
    end
  end
end
