# frozen_string_literal: true

require 'uart'
require 'dotenv'
require 'byebug'
Dotenv.load
require_relative 'mhz19b'

if ENV['RPI'] == '1'
  require 'rpi_gpio'
  RPi::GPIO.set_numbering(:bcm)
end

class Raspberry
  def call(env)
    a = ENV['RPI'] == '1' ? (0..27).map { |pin| RPi::GPIO.setup pin, as: :input; RPi::GPIO.high?(pin) } : []
    pins = [
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
    ]

    [200, {'Content-Type' => 'application/json'}, [pins, Mhz19b.check]]
  end
end
