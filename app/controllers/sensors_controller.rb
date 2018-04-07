class SensorsController < ApplicationController
  def index
    @sensor = Sensor.check
  end

  def create
    render json: Sensor.check
  end
end
