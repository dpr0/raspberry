# frozen_string_literal: true

class Raspberry
  def call(env)
    request_params = Rack::Request.new(env).body.read
    puts request_params
    resp = case env['REQUEST_URI']
           when '/'
             {status: :ok}
           when '/pin17'
             YaGPIO.new(17, YaGPIO::OUTPUT).high
           when '/pin'
             if env['REQUEST_METHOD'] == 'POST'
               params = JSON.parse(request_params)
               pin = YaGPIO.new(params['pin'], YaGPIO::OUTPUT)
               params['status'] ? pin.high : pin.low
               { pin: params['pin'], status: pin.high? }
             end
           when '/pins'
             a = (0..27).to_a #.map { |pin| YaGPIO.new(pin, YaGPIO::OUTPUT).high? }

           when '/mhz19b'
             Mhz19b.check
           when '/bme280'
             @bme280 ||= I2C::Driver::BME280.new(device: 1)
             x = @bme280.all
             { t: (x[:t] * 10).to_i / 10.0, p: (x[:p] * 10).to_i / 10.0, h: (x[:h] * 10).to_i / 10.0 }
           end

    [200, {'Content-Type' => 'application/json'}, [JSON.pretty_generate(resp)]]
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
