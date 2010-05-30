module GluttonRatelimit
  
private
  class ParentLimiter
    attr_reader :executions
    
    def initialize executions, time_period
      @executions = executions
      @time_period = time_period
    end
  end

public    
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
  
  class BurstyTokenBucket < ParentLimiter
    def initialize executions, time_period
      super executions, time_period
      reset_bucket
    end
    
    def reset_bucket
      @oldest_timestamp = Time.now
      @tokens = @executions
    end
    
    def wait
      if @tokens.zero?
        delta = Time.now - @oldest_timestamp
        sleep(@time_period - delta) if delta < @time_period
        reset_bucket
      end
      @tokens -= 1
    end
  end
  
  class AveragedThrottle < ParentLimiter
    def initialize executions, time_period
      super executions, time_period
      reset_bucket
      @before_previous_execution = Time.now
    end
     
    def reset_bucket
      @oldest_timestamp = Time.now
      @tokens = @executions
      @elapsed = 0
    end
    
    def wait
      if @tokens > 0
        executed = @executions - @tokens
        if (executed != 0)
          delta_from_last = Time.now - @before_previous_execution
          @elapsed += delta_from_last
          average_time = @elapsed.to_f / executed 
          remaining = @time_period - (Time.now - @oldest_timestamp)
          throttle = ((remaining.to_f+delta_from_last )/ (@tokens+1)) - average_time
          #puts "Average #{average_time} : Remain #{remaining} : Throttle #{throttle} : Before #{throttle + average_time}"
          sleep throttle if throttle > 0
        end
      else
        delta_from_start = Time.now - @oldest_timestamp
        #sleep(@time_period - delta_from_start) if delta_from_start < @time_period
        if delta_from_start < @time_period
          #puts "Course Corrections #{@time_period - delta_from_start}"
          sleep(@time_period - delta_from_start)
          
        end 
        reset_bucket
      end
      @tokens -= 1
      @before_previous_execution = Time.now
    end
  end

end


