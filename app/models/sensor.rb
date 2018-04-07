class Sensor < ApplicationRecord
  require 'uart'

  CHECK_CO2 = "\xFF\x01\x86\x00\x00\x00\x00\x00\x79"
  CALIBRATE = "\xFF\x01\x87\x00\x00\x00\x00\x00\x78"
  ABC_OFF   = "\xFF\x01\x79\x00\x00\x00\x00\x00\x86"
  ABC_ON    = "\xFF\x01\x79\xA0\x00\x00\x00\x00\xE6"

  def self.check
    a = send_command(CHECK_CO2)
    crc = 256 - a[1..7].reduce(&:+)%256
    create(temp: (a[4] - 40), co2: (a[2] * 256 + a[3]), crc: crc ) if crc == a[8]
  end

  def self.calibarte
    send_command(CALIBRATE)
  end

  def self.abc_on
    send_command(ABC_ON)
  end

  def self.abc_off
    send_command(ABC_OFF)
  end

  private

  def self.send_command(command)
    UART.open('/dev/ttyAMA0') { |s| s.write(command); s.read(9).unpack('C9')}
  end
end
