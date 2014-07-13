
def to_radian(x)
  return x*Math::PI/180
end

def to_equirect(lat, lon)
  x = lon * Math.cos(lat)
  y = lat
  coordinates = [x, y]
  return coordinates
end

center_lat = 40.741551
center_lon = -73.989634

top_east_lat = 40.764292
top_east_lon = -73.972961

lat_rad = to_radian(center_lat)
lon_rad = to_radian(center_lon)

top_east_lat_rad = to_radian(top_east_lat)
top_east_lon_rad = to_radian(top_east_lon)


center_point = to_equirect(lat_rad, lon_rad)
top_east_point = to_equirect(top_east_lat_rad, top_east_lon_rad)

puts center_point
puts top_east_point

@slope = (top_east_point[1]-center_point[1])/(top_east_point[0]-center_point[0])

@intercept = center_point[1] - @slope * center_point[0]

puts @slope
puts @intercept

def get_lon(lat)
  return (lat-@intercept)/@slope
end

def convert_lon(lon_er, lat_er)
  lon = lon_er / Math.cos(lat_er)
  l_d = lon*180/Math::PI
  return l_d
end
station_lat = 40.761773
station_lon = -73.979098

test_lon = get_lon(top_east_lat_rad)
tl2 = convert_lon(test_lon, top_east_lat_rad)

puts tl2


test_lon = get_lon(to_radian(station_lat))
tl2 = convert_lon(test_lon, to_radian(station_lat))

puts tl2


