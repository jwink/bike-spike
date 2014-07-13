
require 'active_record'

require 'pg'

ActiveRecord::Base.establish_connection(
    :adapter => 'postgresql',
    :database => 'all_bike_data'
  )

class Stationpoint < ActiveRecord::Base
end

y=Stationpoint.where(station_id: 514, hour: 19, day_of_week: [1,2,3,4])

x = y.as_json

puts x


