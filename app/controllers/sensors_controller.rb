class SensorsController < ApplicationController
  def index
    @sensor = Sensor.check
    respond_to do |format|
      format.html
      format.json { render json: @sensor }
    end
  end

  def set_gpio
    return if ENV['RPI'] == '0'
    pins = Gpio::GPIO.flatten.map { |x| x[:num] if x[:num].is_a?(Integer) && x[:color] == '#24AF54' }.compact.sort
    set_pins = params[:gpio_pins].map(&:to_i).sort
    p pins
    pins.each do |pin|
      RPi::GPIO.setup(pin, as: :input)
      state = RPi::GPIO.high?(pin)
      RPi::GPIO.setup(pin, as: :output) if (set_pins.include?(pin) && !state) || (!set_pins.include?(pin) && state)
      RPi::GPIO.set_high(pin) if set_pins.include?(pin) && !state
      RPi::GPIO.set_low(pin) if !set_pins.include?(pin) && state
    end
  end
end
