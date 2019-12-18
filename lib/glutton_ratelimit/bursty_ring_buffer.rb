module GluttonRatelimit
  
  class BurstyRingBuffer < ParentLimiter
    
    def oldest_timestamp
      @timestamps ||= Array.new executions, (Time.now - @time_period) 
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


