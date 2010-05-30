module GluttonRatelimit
  class BurstyRingBuffer
    attr_reader :executions
    
    def initialize executions, time_period
      @executions = executions
      @time_period = time_period
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
  
  class BurstyTokenBucket
    attr_reader :executions
    
    def initialize executions, time_period
      @executions = executions
      @time_period = time_period
      reset_bucket
    end
    
    def reset_bucket
      @oldest_timestamp = Time.now
      @tokens = executions
    end
    
    def wait
      if @tokens > 0
        @tokens -= 1
      else
        delta = Time.now - @oldest_timestamp
        sleep(@time_period - delta) if delta < @time_period
        reset_bucket
      end
    end
  end
end


