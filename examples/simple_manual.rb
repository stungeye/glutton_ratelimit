# $LOAD_PATH << File.dirname(__FILE__) +'/../lib'
require 'rubygems'
require 'glutton_ratelimit'

puts "Maximum of 12 executions every 5 seconds (Bursty):"
rl = GluttonRatelimit::BurstyTokenBucket.new 12, 5

start = Time.now
n = 0

rl.times(25) do
  puts "#{n += 1} - #{Time.now - start}"
  # Simulating a constant-time task:
  sleep 0.1
end

# The 25th execution should occur after 10 seconds has elapsed.

puts "Maximum of 3 executions every 3 seconds (Averaged):"
rl = GluttonRatelimit::AveragedThrottle.new 3, 3
# AverageThrottle will attempt to evenly space executions within the allowed period.

start = Time.now
n = 0

rl.times(7) do 
  puts "#{n += 1} - #{Time.now - start}"
  # Simulating a 0 to 1 second random-time task:
  sleep rand
end

# The 7th execution should occur after 6 seconds has elapsed.