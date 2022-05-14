# frozen_string_literal: true

class Raspberry
  def call(env)
    @request = Rack::Request.new(env)
    request_params = @request.body.read
    puts request_params
    [200, { 'Content-Type' => 'application/json' }, [JSON.pretty_generate(resp)]]
  end

  def resp
    puts path_fragments
    pin = path_fragments[1]
    case path_fragments.first
    when ''
      { status: :ok }
    when 'set_pin'
      { status: pinout(pin).high }
    when 'reset_pin'
      { status: pinout(pin).low }
    when 'toggle_pin'
      p = pinout(pin)
      { status: p.high? ? p.low : p.high }
    when 'pin'
      if env['REQUEST_METHOD'] == 'POST'
        params = JSON.parse(request_params)
        p = pinout(params['pin'] || pin)
        params['status'] ? p.high : p.low
        { pin: params['pin'], status: p.high? }
      else
        { status: pinout(pin).high? }
      end
    when 'pins'
      (0..27).map { |p| [7, 8].include?(p) ? true : pinout(p).high? }
    when 'mhz19b'
      Mhz19b.check
    when 'bme280_2'
      bme ||= I2C::Driver::BME280.new(device: 1, i2c_address: 119) # 0x77
      bme ? json(bme.all) : {}
    when 'bme280'
      bme ||= I2C::Driver::BME280.new(device: 1) # 0x76
      bme ? json(bme.all) : {}
    end
  end

  def json(x)
    { t: (x[:t] * 10).to_i / 10.0, p: (x[:p] * 10).to_i / 10.0, h: (x[:h] * 10).to_i / 10.0 }
  end

  def pinout(pin)
    YaGPIO.new(pin, YaGPIO::OUTPUT)
  end

  def path_fragments
    @request.path.split('/').reject(&:empty?)
  end
end

# @i2c = ::I2C.create("/dev/i2c-1")
# I2C_COMM1 = 0x40
# I2C_COMM2 = 0xC0
# I2C_COMM3 = 0x80
# digit_to_segment = [ # [63, 6, 91, 79, 102, 109, 125, 7, 127, 111, 119, 124, 57, 94, 121, 113]
#     0b0111111, # 0
#     0b0000110, # 1
#     0b1011011, # 2
#     0b1001111, # 3
#     0b1100110, # 4
#     0b1101101, # 5
#     0b1111101, # 6
#     0b0000111, # 7
#     0b1111111, # 8
#     0b1101111, # 9
#     0b1110111, # A
#     0b1111100, # b
#     0b0111001, # C
#     0b1011110, # d
#     0b1111001, # E
#     0b1110001  # F
# ]
# @i2c.write(0x00, 0x00, 0x00) # i2cdetect -y 1
