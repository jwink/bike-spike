
require 'active_record'

require 'pg'

require 'csv'

ActiveRecord::Base.establish_connection(
    :adapter => 'postgresql',
    :database => 'bike-vis-app_development'
  )

class Station < ActiveRecord::Base
  def self.add_station(station)

    label_hash = {}
    label_hash['id'] = 0
    label_hash['label'] = 1
    label_hash['latitude'] = 2
    label_hash['longitude'] = 3
    label_hash['n1'] = 4
    label_hash['n2'] = 5
    label_hash['n3'] = 6
    label_hash['n4'] = 7
    label_hash['n5'] = 8
    label_hash['d1'] = 9
    label_hash['d2'] = 10
    label_hash['d3'] = 11
    label_hash['d4'] = 12
    label_hash['d5'] = 13


    station_hash = {}
    station_hash['citibike_id'] = station[label_hash['id']]
    station_hash['label'] =      station[label_hash['label']]
    station_hash['latitude'] =   station[label_hash['latitude']]
    station_hash['longitude'] =  station[label_hash['longitude']]
    station_hash['near1'] =      station[label_hash['n1']]
    station_hash['near2'] =      station[label_hash['n2']]
    station_hash['near3'] =      station[label_hash['n3']]
    station_hash['near4'] =      station[label_hash['n4']]
    station_hash['near5'] =      station[label_hash['n5']]
    station_hash['dist1'] =      station[label_hash['d1']]
    station_hash['dist2'] =      station[label_hash['d2']]
    station_hash['dist3'] =      station[label_hash['d3']]
    station_hash['dist4'] =      station[label_hash['d4']]
    station_hash['dist5'] =      station[label_hash['d5']]

    Station.create(station_hash)
  end
end

x = CSV.read("labelsfull.csv")

x.each do |station|
  puts station[1]
  if station[1] != "label"
    Station.add_station(station)
  end
end
