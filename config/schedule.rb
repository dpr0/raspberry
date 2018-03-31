set :output, "/cron_log.log"

every 1.minutes do
  runner "Sensor.check"
end
