module JsonImported
  extend ActiveSupport::Concern

  included do
    #has_many :bars

    #class_attribute :foo
  end

  
  module ClassMethods
    def import!(station, ignore_older_than = Time.now)

    end
  end
  
end