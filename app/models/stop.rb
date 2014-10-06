class Stop < ActiveRecord::Base  
  #SCHEMA:
  #datetime :scheduled_time
  #string :line_name
  #string :line_direction
  #string :line_identifier
  #string :line_type
  #string :key
  
  belongs_to :station
  
  validates :scheduled_time, :uniqueness => {:scope => [:line_name, :line_direction, :station_id]}
  
  include JsonImported # needed for #load_or_get_upcomming!
  
  # SCOPES AND FINDERS:  
  default_scope { order(scheduled_time: :asc) }
  
  scope :upcomming, -> { where(arel_table[:scheduled_time].gteq(Time.now)) }
  
  def self.for_station(station_filter_name)
    where(station_id: Station.find_by_name(station_filter_name).id)
  end
  
  def self.load_or_get_upcomming!
    stops = self.upcomming
    if (stops.empty? || (Time.now - Stop.maximum(:created_at)) > 5.minutes) && (stops.empty? || stops.group_by(&:station).values.map(&:count).min < 5)
      Station.all.each do |station|
        self.import!(station) # import! made available by concern JsonImported
      end
    end
    self.upcomming
  end
  
  # INSTANCE METHODS
  def station_name
    self.station.name
  end
  
end
