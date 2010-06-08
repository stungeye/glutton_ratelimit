require 'rubygems'
require 'glutton_ratelimit'

class LimitInstanceMethods
  extend GluttonRatelimit
    
  def initialize
    @start = Time.now
  end
  
  def limit_me
    puts "#{Time.now - @start}"
    sleep 0.001
  end
  
  def cap_me
    puts "#{Time.now - @start}"
    sleep 0.001
  end
  
  rate_limit :limit_me, 6, 6
  rate_limit :cap_me, 6, 6, GluttonRatelimit::BurstyTokenBucket
end

t = LimitInstanceMethods.new

puts "Six requests every 6 seconds Averaged: "
10.times { t.limit_me }
puts "Six requests every 6 seconds Bursty: "
10.times { t.cap_me }