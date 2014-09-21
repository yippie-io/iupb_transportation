# see https://github.com/rails/jbuilder for syntax

json.array! @stops, :station_name, :scheduled_time, :line_name, :line_direction