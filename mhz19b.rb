# frozen_string_literal: true

class Mhz19b
  CHECK     = '\xFF\x01\x86\x00\x00\x00\x00\x00\x79'
  CALIBRATE = '\xFF\x01\x87\x00\x00\x00\x00\x00\x78'
  ABC_ON    = '\xFF\x01\x79\xA0\x00\x00\x00\x00\xE6'
  ABC_OFF   = '\xFF\x01\x79\x00\x00\x00\x00\x00\x86'

  class << self
    def check
      a = send_command(CHECK)
      return { temp: nil, co2: nil, crc: false } unless a

      { temp: (a[4] - 40), co2: (a[2] * 256 + a[3]), crc: (256 - a[1..7].reduce(&:+) % 256) == a[8] }
    end

    def calibrate
      send_command(CALIBRATE)
    end

    def abc_on
      send_command(ABC_ON)
    end

    def abc_off
      send_command(ABC_OFF)
    end

    private

    def send_command(command)
      UART.open('/dev/ttyAMA0') do |s|
        s.write(command)
        s.read(9).unpack('C9')
      end
    rescue Errno::ENOENT
      # Ignored
    end
  end
end
