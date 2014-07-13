
require 'csv'

day = '6'

x = CSV.read("../bike/bike_data/June" + day + "Bikes.csv")

puts x.length
#puts y
puts x[0]
#y = x[7274]

counter = 1
2.times do

  y = x[counter]
  puts y.length

  z= y[6]

  puts "raw time: #{z}"

  # gets from string to DateTime type
  z = DateTime.parse(z)


  # converts to local time
  z = z.to_time

  puts "lcoal time?: #{z}"


  # gets day of week
  puts "weekday:  #{z.wday}"
  puts "month:  #{z.month}"
  puts "year:  #{z.year}"
  puts "day:  #{z.day}"
  puts "hour:  #{z.hour}"
  counter=7000
end
