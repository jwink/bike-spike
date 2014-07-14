
require 'active_record'

require 'pg'

require 'csv'

ActiveRecord::Base.establish_connection(
    :adapter => 'postgresql',
    :database => 'all_bike_data'
  )

class Saturation < ActiveRecord::Base
end


quads_array = ['sw', 'bk', 'se', 'nw', 'ne']


hours_array = *(0..23)


quads_array.each do |quad|
  hours_array.each do |hour|
    bike_sum = 0
    dock_sum = 0
    counter = 0
    capacity = 0
    s_sat = 0
    stations = Saturation.where(quadrant: quad, hour: hour)
    stations.each do |station|
      bike_sum += station.avg_bikes
      dock_sum += station.avg_docks
      counter += 1
      s_sat += station.saturation
      capacity += station.capacity
    end
    q_saturation = bike_sum.to_f / capacity.to_f
    sanity_check = s_sat / counter.to_f
    puts "#{quad}, #{hour}, #{q_saturation}, #{sanity_check}"
  end
end
