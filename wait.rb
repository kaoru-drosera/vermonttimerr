require 'timers'

t = Time.new(0)
countdown_time_in_seconds = 300 # change this value

puts t + countdown_time_in_seconds

countdown_time_in_seconds.downto(0) do |seconds|
  puts (t + seconds).strftime('%H:%M:%S')
  sleep 1
end
puts "TIME UP"

# timers = Timers::Group.new
# lefttime = 5
#
# puts "start"
# timeleft = 0.25
#
# now_and_every_five_seconds = timers.now_and_every(timeleft) { puts "Now and in another 5 seconds" }
# loop { timers.wait }

# for left in 0..lefttime do
#   left = (lefttime + 1) - left
#   puts left.strftime("%R")
# end
