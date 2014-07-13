
def to_radian(x)
  return x*Math::PI/180
end


def dist_two(lat1, lon1, lat2, lon2)
  lat1rad = to_radian(lat1)
  lon1rad = to_radian(lon1)
  lat2rad = to_radian(lat2)
  lon2rad = to_radian(lon2)

  xdist = (lon1rad - lon2rad) * Math.cos((lat1rad+lat2rad)/2)
  ydist = lat1rad-lat2rad
  d = 6371 * Math.sqrt(xdist**2 + ydist**2)
  return d

end

puts dist_two(40.76727216, -73.99392888, 40.771522, -73.990541)/1.60934











