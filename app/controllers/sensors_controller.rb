class SensorsController < ApplicationController
  before_action :set_sensor, only: [:edit, :update, :destroy]

  def index
    sensors = Sensor.where(crc: true)
    @temp = {
        labels: sensors.map(&:created_at),
        datasets: [{
                       label:           'temp',
                       backgroundColor: 'rgba(220,220,220,0.2)',
                       borderColor:     'rgba(220,220,220,1)',
                       data:            sensors.map(&:temp)
                   }]
    }
    @co2 = {
        labels: sensors.map(&:created_at),
        datasets: [{
                       label:           'co2',
                       backgroundColor: 'rgba(151,187,205,0.2)',
                       borderColor:     'rgba(151,187,205,1)',
                       data:            sensors.map(&:co2)
                   }]
    }
  end

  def edit
  end

  def create
    Sensor.check
    redirect_to :index
  end

  def update
    @sensor.update(sensor_params)
    redirect_to :index
  end

  def destroy
    @sensor.destroy
    redirect_to :index
  end

  def set

  end

  private
    def set_sensor
      @sensor = Sensor.find(params[:id])
    end

    def sensor_params
      params.fetch(:sensor, {})
    end
end
