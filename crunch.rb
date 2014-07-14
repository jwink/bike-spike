
require 'active_record'

require 'pg'

require 'csv'

ActiveRecord::Base.establish_connection(
    :adapter => 'postgresql',
    :database => 'all_bike_data'
  )

class Station < ActiveRecord::Base
end

class Average < ActiveRecord::Base
end

class Saturation < ActiveRecord::Base
end


stations = Station.all

days_array = [1,2,3,4,5]
hours_array = *(0..23)

#hours_array = [8]
data = []

stations.each do |station|
  hours_array.each do |hour|
    bikes = 0
    docks = 0
    hour_hash = {}
    hour_hash['station_id'] = station.station_id
    hour_hash['capacity'] = station.capacity
    hour_hash['quadrant'] = station.quadrant
    days_array.each do |day|
      average = Average.where(station_id: station.station_id, hour: hour, day_of_week: day).take
      bikes += average.avail_bikes_avg
      docks += average.avail_docks_avg
    end
    avg_bikes = bikes / 5.0
    avg_docks = docks / 5.0
    hour_hash['avg_bikes'] = avg_bikes
    hour_hash['avg_docks'] = avg_docks
    hour_hash['hour'] = hour
    hour_hash['saturation'] = avg_bikes / station.capacity.to_f
    Saturation.create(hour_hash)
    data << hour_hash
  end
end




