class StationsController < ApplicationController
  def index
    expires_in 1.day, public: true
    render json: Station.all, except: [:id, :query_name, :created_at, :updated_at]
  end
end
