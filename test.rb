require 'rpi_gpio'
require 'i2c'
RPi::GPIO.set_numbering :bcm
@i2c = ::I2C.create("/dev/i2c-1")

I2C_COMM1 = 0x40
I2C_COMM2 = 0xC0
I2C_COMM3 = 0x80
digit_to_segment = [ # [63, 6, 91, 79, 102, 109, 125, 7, 127, 111, 119, 124, 57, 94, 121, 113]
    0b0111111, # 0
    0b0000110, # 1
    0b1011011, # 2
    0b1001111, # 3
    0b1100110, # 4
    0b1101101, # 5
    0b1111101, # 6
    0b0000111, # 7
    0b1111111, # 8
    0b1101111, # 9
    0b1110111, # A
    0b1111100, # b
    0b0111001, # C
    0b1011110, # d
    0b1111001, # E
    0b1110001  # F
]

dio = 2
clk = 3
RPi::GPIO.setup dio, as: :output  
RPi::GPIO.setup clk, as: :output

@i2c.write(0x00, 0x00, 0x00) # i2cdetect -y 1

pin = 5
RPi::GPIO.setup pin, as: :input
puts "pin#{pin} high?: #{RPi::GPIO.high? pin}"
puts "pin#{pin} low?:  #{RPi::GPIO.low? pin}"

RPi::GPIO.setup pin, as: :input, pull: :down
RPi::GPIO.setup pin, as: :input, pull: :up
RPi::GPIO.setup pin, as: :input, pull: :off

RPi::GPIO.setup pin, as: :output
RPi::GPIO.set_high pin
RPi::GPIO.set_low pin
RPi::GPIO.setup pin, as: :output, initialize: :high
RPi::GPIO.setup pin, as: :output, initialize: :low

PIN_NUM = 5
PWM_FREQ = 100
DUTY_CYCLE = 10

pwm = RPi::GPIO::PWM.new(PIN_NUM, PWM_FREQ)
pwm.start DUTY_CYCLE
pwm.duty_cycle # get
pwm.duty_cycle = NEW_DUTY_CYCLE # set
pwm.frequency # get
pwm.frequency = NEW_FREQUENCY # set
pwm.gpio
pwm.stop
pwm.running?
RPi::GPIO.clean_up pin
RPi::GPIO.clean_up

