
require 'active_record'

require 'pg'

require 'csv'

ActiveRecord::Base.establish_connection(
    :adapter => 'postgresql',
    :database => 'all_bike_data'
  )


class Sat < ActiveRecord::Base
end

class Station < ActiveRecord::Base
end

stations = Station.all
data = Sat.all

all_info = []
empty_count = 0
full_count = 0
volatile_count = 0
test = []

stations.each do |station|
  station_hash = {}
  station_hash['citibike_id'] = station.station_id
  station_hash['latitude'] = station.latitude
  station_hash['longitude'] = station.longitude
  saturation_array = []
  data.each do |obs|
    if obs.citibike_id == station.station_id
      saturation_array << obs.saturation
    end
  end
  if saturation_array.max < 0.3
    station_hash['empty'] = 1
    empty_count += 1
  else
    station_hash['empty'] = 0
  end
  if saturation_array.min > 0.5
    station_hash['full'] = 1
    full_count += 1
  else
    station_hash['full'] = 0
  end
  flag = 1
  saturation_array.each do |sat|
    if sat < 0.4 || sat > 0.6
      flag = 0
    end
  end
  station_hash['goldielocks'] = flag
  if (saturation_array.max - saturation_array.min) > 0.7
    station_hash['volatile'] = 1
    volatile_count += 1
  else
    station_hash['volatile'] = 0
  end
  test << station_hash['empty'] + station_hash['full']+
          station_hash['goldielocks'] + station_hash['volatile']
  all_info << station_hash
end

all_info.each do |sta|
  if sta['goldielocks'] == 1
    temp = Station.find_by(station_id: sta['citibike_id'])
    puts temp.label
  end
end

puts all_info
puts test.reduce(:+)
