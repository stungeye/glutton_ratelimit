class LimitClassMethods
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
  
  limit_method :limit_me, 6, 6
  limit_method :cap_me, 3, 6
end

t = LimitClassMethods.new

10.times { t.limit_me }
10.times { t.cap_me }