class StopsController < ApplicationController
  def index
    @stops = Stop.load_or_get_upcomming!
    @stops = @stops.limit(params[:limit].to_i) if is_int?(params[:limit])
    cache_results_accordingly
  end

  def filter
    @stops = Stop.load_or_get_upcomming!
    unless params[:station].blank?
      @stops = @stops.for_station(params[:station])
    end
    unless params[:line].blank?
      @stops = @stops.where(line_name: params[:line])
    end
    cache_results_accordingly
  end
  
  def legacy
    @stops = Stop.load_or_get_upcomming!.first(15)
    json_result = @stops.map do |stop|
      {
        date: stop.scheduled_time.strftime("%Y-%m-%d %H:%M:%S"),
        direction: stop.line_direction,
        line: stop.line_name,
        station: stop.station_name
      }
    end
    cache_results_accordingly
    if params[:callback]
       render json: json_result, callback: params[:callback]
    else
       render json: json_result  
    end
  end
  
  protected
  def cache_results_accordingly(stale_at = nil)
    if stale_at || !@stops.empty?
      seconds_til_first_bus = (stale_at || @stops.first.scheduled_time) - Time.now
      expires_in seconds_til_first_bus.seconds, public: true
    end
  end
end
