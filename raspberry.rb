# frozen_string_literal: true

class Raspberry
  def call(env)
    resp = case env['REQUEST_URI']
           when '/'
             {status: :ok}
           when '/pins'
             a = (0..27) #.map { |pin| YaGPIO.new(pin, YaGPIO::OUTPUT).high? }
             {data: [
                { id:  1, color: '#DAA01D', num: '3v3' }, { id:  2, color: 'red',     num: '5v0' },
                { id:  3, color: '#4792FF', num: a[2]  }, { id:  4, color: 'red',     num: '5v0' },
                { id:  5, color: '#4792FF', num: a[3]  }, { id:  6, color: '#000000', num: 'GND' },
                { id:  7, color: '#24AF54', num: a[4]  }, { id:  8, color: '#6C42AA', num: a[14] },
                { id:  9, color: '#000000', num: 'GND' }, { id: 10, color: '#6C42AA', num: a[15] },
                { id: 11, color: '#24AF54', num: a[17] }, { id: 12, color: '#24AF54', num: a[18] },
                { id: 13, color: '#24AF54', num: a[27] }, { id: 14, color: '#000000', num: 'GND' },
                { id: 15, color: '#24AF54', num: a[22] }, { id: 16, color: '#24AF54', num: a[23] },
                { id: 17, color: '#DAA01D', num: '3v3' }, { id: 18, color: '#24AF54', num: a[24] },
                { id: 19, color: '#AA37A1', num: a[10] }, { id: 20, color: '#000000', num: 'GND' },
                { id: 21, color: '#AA37A1', num: a[9]  }, { id: 22, color: '#24AF54', num: a[25] },
                { id: 23, color: '#AA37A1', num: a[11] }, { id: 24, color: '#AA37A1', num: a[8]  },
                { id: 25, color: '#000000', num: 'GND' }, { id: 26, color: '#AA37A1', num: a[7]  },
                { id: 27, color: '#4792FF', num: a[0]  }, { id: 28, color: '#4792FF', num: a[1]  },
                { id: 29, color: '#24AF54', num: a[5]  }, { id: 30, color: '#000000', num: 'GND' },
                { id: 31, color: '#24AF54', num: a[6]  }, { id: 32, color: '#24AF54', num: a[12] },
                { id: 33, color: '#24AF54', num: a[13] }, { id: 34, color: '#000000', num: 'GND' },
                { id: 35, color: '#AA37A1', num: a[19] }, { id: 36, color: '#24AF54', num: a[16] },
                { id: 37, color: '#24AF54', num: a[26] }, { id: 38, color: '#AA37A1', num: a[20] },
                { id: 39, color: '#000000', num: 'GND' }, { id: 40, color: '#AA37A1', num: a[21] }
             ]}
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
