class Stop < ActiveRecord::Base  
  #SCHEMA:
  #datetime :scheduled_time
  #string :line_name
  #string :line_direction
  #string :line_identifier
  #string :line_type
  #string :key
  
  belongs_to :station
  
  include JsonImported
  
  # SCOPES AND FINDERS:  
  default_scope { order(scheduled_time: :asc) }
  
  scope :upcomming, -> { where(arel_table[:scheduled_time].gteq(Time.now)) }
  
  def self.for_station(station_filter_name)
    where(station_id: Station.find_by_name(station_filter_name).id)
  end
  
  # INSTANCE METHODS
  def station_name
    self.station.name
  end
  
end
