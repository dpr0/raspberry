class Sensor < ApplicationRecord
  require 'uart'

  def self.check
    a = send_command("\xFF\x01\x86\x00\x00\x00\x00\x00\x79")
    return {} unless a
    { temp: (a[4] - 40), co2: (a[2] * 256 + a[3]), crc: (256 - a[1..7].reduce(&:+)%256) == a[8] }
  end

  def self.calibrate
    send_command("\xFF\x01\x87\x00\x00\x00\x00\x00\x78")
  end

  def self.abc_on
    send_command("\xFF\x01\x79\xA0\x00\x00\x00\x00\xE6")
  end

  def self.abc_off
    send_command("\xFF\x01\x79\x00\x00\x00\x00\x00\x86")
  end

  private

  def self.send_command(command)
    UART.open('/dev/ttyAMA0') { |s| s.write(command); s.read(9).unpack('C9')}
  rescue Errno::ENOENT
  end
end
