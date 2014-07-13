


require 'active_record'

require 'pg'

require 'csv'

ActiveRecord::Base.establish_connection(
    :adapter => 'postgresql',
    :database => 'all_bike_data'
  )

class Station < ActiveRecord::Base

  def self.to_radian(x)
    return x*Math::PI/180
  end

  def self.horizontal(lat, lon)
    return Math.cos(lat) * Math.cos(lon)
  end

  def self.vertical(lat, lon)
    return Math.cos(lat) * Math.sin(lon)
  end

  def self.height(lat)
    return Math.sin(lat)
  end


end


x = Station.all

lat_lon_array = []

x.each do |station|
  temp_ll = []
  lat = Station.to_radian(station.latitude)
  lon = Station.to_radian(station.longitude)
  horizontal = Station.horizontal(lat, lon)
  vertical = Station.vertical(lat, lon)
  height = Station.height(lat)
  temp_ll << horizontal
  temp_ll << vertical
  temp_ll << height
  lat_lon_array << temp_ll
end

sum_horizontal = 0
sum_vertical = 0
sum_height = 0

lat_lon_array.each do |geo|
  sum_horizontal += geo[0]
  sum_vertical += geo[1]
  sum_height += geo[2]
end

avg_horizontal = sum_horizontal / lat_lon_array.length
avg_vertical = sum_vertical / lat_lon_array.length
avg_height = sum_height / lat_lon_array.length

final_rad_lon = Math.atan2(avg_vertical, avg_horizontal)
hypotenuse = Math.sqrt(avg_horizontal**2 + avg_vertical**2)

final_rad_lat = Math.atan2(avg_height, hypotenuse)

final_lat = final_rad_lat * 180/Math::PI
final_lon = final_rad_lon * 180/Math::PI

puts "lat:  #{final_lat} and lon:  #{final_lon}"

ll = []

x.each do |station|
  station_info = {}
  station_info['lat'] = station.latitude
  station_info['lon'] = station.longitude
  ll << station_info
end

puts ll.to_json

