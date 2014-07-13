
require 'active_record'

require 'pg'

require 'csv'

ActiveRecord::Base.establish_connection(
    :adapter => 'postgresql',
    :database => 'all_bike_data'
  )


class Stationpoint < ActiveRecord::Base

  def self.capacity(station_id)
    x = Stationpoint.where(station_id: station_id)
    total_array = Hash.new(0)
    x.each do |observation|
      capacity = observation.avail_bikes + observation.avail_docks
      total_array[capacity] = total_array[capacity] + 1
    end
    return total_array
  end
end

class Station < ActiveRecord::Base
end


station_hash = {}

x = Station.all

x.each do |station|
  station_hash[station.station_id] = {}
end

#puts station_hash
fin_hash = {}
station_hash.each do |key, value|
  station_hash[key] = Stationpoint.capacity(key)
  add_array = station_hash[key].keys
  max = add_array.max
  freq = station_hash[key][max]
  perc = freq.to_f/966.0
  fin_hash[key] = add_array.max
  puts "Station: #{key}, max: #{add_array.max}, perc: #{perc}"
end


puts fin_hash

