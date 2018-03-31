class SensorsController < ApplicationController
  before_action :set_sensor, only: [:edit, :update, :destroy]

  def index
    @sensors = Sensor.where(crc: true)
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
