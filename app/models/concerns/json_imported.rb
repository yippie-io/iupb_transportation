module JsonImported
  extend ActiveSupport::Concern

  included do
    #has_many :bars

    #class_attribute :foo
  end

  
  module ClassMethods
    def import!(station, ignore_older_than = Time.now)
      stops = Vrrf.new(station).get_stops
      import_results = stops.map {|stop| make_stop_from_json_result(stop, station)}
      if (failed_imports = import_results.reject {|import| import }.count) > 0
        Rails.logger.warning "JsonImported: #{failed_imports} Bus stops were not imported successfully (station: #{station.name})"
      end
    end
    
    def make_stop_from_json_result(json_result, station)
      stop = Stop.new
      stop.scheduled_time = DateTime.strptime("#{json_result["sched_date"]} #{json_result["sched_time"]}", "%d.%m.%Y %H:%M")
      stop.line_direction = json_result["lineref"]["direction"]
      stop.line_name = json_result["lineref"]["name"]
      stop.line_identifier = json_result["lineref"]["identifier"]
      stop.key = json_result["key"]
      stop.station = station
      stop.save
    end
  end
  
end

class Vrrf
  include HTTParty
  base_uri 'http://vrrf.finalrewind.org/Paderborn'
  
  def initialize(station)
    raise "Station must have a `query_name` to make this work..." unless station.respond_to?(:query_name)
    @station = station
  end

  # query API for stops for given station
  def get_stops(options={})
    begin
      self.class.get("/#{ERB::Util.url_encode(@station.query_name)}.json?frontend=json", options).try(:[], "raw")
    rescue
      []
    end
  end
end