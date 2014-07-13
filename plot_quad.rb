
require 'active_record'

require 'pg'

require 'csv'

ActiveRecord::Base.establish_connection(
    :adapter => 'postgresql',
    :database => 'bike-vis-app_development'
  )

class Station < ActiveRecord::Base
end


def to_radian(x)
  return x*Math::PI/180
end

def to_equirect(lat, lon)
  return lon * Math.cos(lat)
end

def get_lon(lat, slope, intercept)
  return (lat-intercept)/slope
end

def get_slope(lat1, lon1, lat2, lon2)
  return (lat2-lat1)/(lon2-lon1)
end

def get_intercept(lat1, lon1, slope)
  return (lat1 - slope*lon1)
end

def convert_lon(lon_er, lat_er)
  lon = lon_er / Math.cos(lat_er)
  l_d = lon*180/Math::PI
  return l_d
end

def which_quad(point_lon, lon_ns, lon_ew)
  if point_lon > lon_ew && point_lon < lon_ns
    return "nw"
  elsif point_lon > lon_ew && point_lon > lon_ns
    return "ne"
  elsif point_lon < lon_ew && point_lon < lon_ns
    return "sw"
  else
    return "se"
  end
end





center_lat = to_radian(40.741551)
center_lon = to_equirect(center_lat, to_radian(-73.989634))
north_lat  = to_radian(40.764292)
north_lon  = to_equirect(north_lat, to_radian(-73.972961))
west_lat   = to_radian(40.748832)
west_lon   = to_equirect(west_lat, to_radian(-74.006926))

ns_slope = get_slope(center_lat, center_lon, north_lat, north_lon)
ns_intercept = get_intercept(center_lat, center_lon, ns_slope)

ew_slope = get_slope(center_lat, center_lon, west_lat, west_lon)
ew_intercept = get_intercept(center_lat, center_lon, ew_slope)

test_lat = to_radian(40.754901)
test_lon = -73.984166
lon_ns = convert_lon(get_lon(test_lat, ns_slope,ns_intercept), test_lat)
lon_ew = convert_lon(get_lon(test_lat, ew_slope,ew_intercept), test_lat)

#puts "#{test_lon}, #{lon_ns}, #{lon_ew}"
#puts which_quad(test_lon, lon_ns, lon_ew)

stations = Station.all

latlon = []
stations.each do |station|
  temp_hash = {}
  temp_hash['lat'] = station.latitude
  temp_hash['lon'] = station.longitude
  test_lat = to_radian(station.latitude)
  test_lon = station.longitude
  lon_ns = convert_lon(get_lon(test_lat, ns_slope,ns_intercept), test_lat)
  lon_ew = convert_lon(get_lon(test_lat, ew_slope,ew_intercept), test_lat)
  temp_hash['quad'] = which_quad(test_lon, lon_ns, lon_ew)
  latlon << temp_hash
  curr_station = Station.find(station.id)
  curr_station.quadrant = temp_hash['quad']
  curr_station.save
end

quad = []
latlon.each do |point|
  if point['quad'] == "se"
    temp_hash = {}
    temp_hash['lat'] = point['lat']
    temp_hash['lon'] = point['lon']
    quad << temp_hash
  end
end

puts quad.length
puts quad.to_json


