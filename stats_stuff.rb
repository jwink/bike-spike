
require 'active_record'

require 'pg'

require 'csv'

ActiveRecord::Base.establish_connection(
    :adapter => 'postgresql',
    :database => 'all_bike_data'
  )


class Stationpoint < ActiveRecord::Base
end


y=Stationpoint.select("month, day, hour, sum(avail_bikes)").group("month, day, hour")

x = y.as_json


min_place = 0
max_place = 0
curr_min = x[0]['sum']
curr_max = x[0]['sum']

x.each_with_index do |time, index|
  if time['sum'] > curr_max
    curr_max = time['sum']
    max_place = index
  end

  if time['sum'] < curr_min
    curr_min = time['sum']
    min_place = index
  end

end




puts x[max_place]['sum']
puts x[max_place]
puts curr_max
puts x[min_place]['sum']
puts x[min_place]
puts curr_min
puts x.length







