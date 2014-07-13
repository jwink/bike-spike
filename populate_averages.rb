

require 'active_record'

require 'pg'

require 'csv'

ActiveRecord::Base.establish_connection(
    :adapter => 'postgresql',
    :database => 'all_bike_data'
  )

class Stationpoint < ActiveRecord::Base
end

class Station < ActiveRecord::Base
end

class Average < ActiveRecord::Base
  def self.station_average(station_id)
    for hour in 0..23
      for day in 0..6
        station_info_raw = Stationpoint.where(station_id: station_id, hour: hour, day_of_week: day)
        station_info = station_info_raw.as_json
        puts station_info.length
        puts station_info
        avg_hash = {}
        avg_hash['station_id'] = station_id
        avg_hash['hour'] = hour
        avg_hash['day_of_week'] = day
        avail_bike_sum = 0
        avail_dock_sum = 0
        station_info.each do |observation|
          avail_bike_sum += observation['avail_bikes']
          avail_dock_sum += observation['avail_docks']
        end
        avg_hash['avail_bikes_avg'] = avail_bike_sum / station_info.length.to_f
        avg_hash['avail_docks_avg'] = avail_dock_sum / station_info.length.to_f

        puts avg_hash
        Average.create(avg_hash)

      end
    end
  end
end


x = Station.all

#Average.station_average(x[0].station_id)

x.each do |station|
   Average.station_average(station.station_id)
end

