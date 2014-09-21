class StopsController < ApplicationController
  def index
    @stops = Stop.upcomming
    @stops = @stops.limit(params[:limit].to_i) if is_int?(params[:limit])
    cache_results_accordingly
  end

  def filter
    @stops = Stop.upcomming
    unless params[:station].blank?
      @stops = @stops.for_station(params[:station])
    end
    unless params[:line].blank?
      @stops = @stops.where(line_name: params[:line])
    end
    cache_results_accordingly
  end
  
  def legacy
    @stops = Stop.upcomming.limit(15)
    json_result = @stops.map do |stop|
      {
        date: stop.scheduled_time.strftime("%Y-%m-%d %H:%M:%S"),
        direction: stop.line_direction,
        line: stop.line_name,
        station: stop.station_name
      }
    end
    cache_results_accordingly
    render json: json_result
  end
  
  protected
  def cache_results_accordingly(stale_at = nil)
    seconds_til_first_bus = Time.now - (stale_at || @stops.first.scheduled_time)
    expires_in seconds_til_first_bus.seconds, public: true
  end
end
