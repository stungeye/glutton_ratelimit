require 'rubygems'
require 'glutton_ratelimit'

puts "Maximum of 12 executions every 5 seconds:"
rl = GluttonRatelimit::BurstyTokenBucket.new 12, 5

start = Time.now
25.times do |n|
  # BurstyTokenBucket will allow for a full burst of executions followed by a pause.
  rl.wait
  puts "#{n+1} - #{Time.now - start}"
  # Simulating a constant-time task:
  sleep 0.1
end

# The 25th execution should occur after 10 seconds has elapsed.

puts "Maximum of 3 executions every 3 seconds."
rl = GluttonRatelimit::AveragedThrottle.new 3, 3

start = Time.now
7.times do |n|
  # AverageThrottle will attempt to evenly space executions within the allowed period.
  rl.wait
  puts "#{n+1} - #{Time.now - start}"
  # Simulating a 0 to 1 second random-time task:
  sleep rand
end

# The 7th execution should occur after 6 seconds has elapsed.