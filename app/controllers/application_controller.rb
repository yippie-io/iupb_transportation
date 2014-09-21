class ApplicationController < ActionController::API
  
  protected
  def is_int?(obj)
    Integer(obj) rescue false
  end
end
