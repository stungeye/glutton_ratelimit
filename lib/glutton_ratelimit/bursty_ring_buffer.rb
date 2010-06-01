module GluttonRatelimit
  
  class BurstyRingBuffer < ParentLimiter
    
    def initialize executions, time_period
      super executions, time_period
      @timestamps = Array.new executions, (Time.now - time_period)
    end
    
    def oldest_timestamp
      @timestamps[0]
    end
    
    def current_timestamp= new_stamp
      @timestamps.push(new_stamp).shift
    end
      
    def wait
      delta = Time.now - oldest_timestamp
      sleep(@time_period - delta) if delta < @time_period
      self.current_timestamp = Time.now
    end
    
  end

end


