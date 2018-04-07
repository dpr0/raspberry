class SensorsController < ApplicationController
  def index
    @sensor = Sensor.check
    respond_to do |format|
      format.html
      format.json { render json: @sensor }
    end
  end
end
