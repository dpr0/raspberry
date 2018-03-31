set :output, "/cron_log.log"
env :PATH, ENV['PATH']

every 1.minute do
  runner "Sensor.check"
end
