class StationsController < ApplicationController
  def index
    expires_in 1.day, public: true
    render json: Station.all.map(&:name)
  end
end
