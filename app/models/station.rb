class Station < ActiveRecord::Base
  has_many :stops
  
  def import_stops
    Stop.import!(self)
  end
end
