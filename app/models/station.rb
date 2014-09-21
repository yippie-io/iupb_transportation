class Station < ActiveRecord::Base
  has_many :stops
  
  def import_stops
    Stop.import!(self.query_name, ignore_older_than = Time.now)
  end
end
