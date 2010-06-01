module GluttonRatelimit
  
private
  # All the other classes extend this parent and are therefore
  # constructed in the same manner.
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
      @total_task_time = 0
    end
    
    def wait
      executed_this_period = @executions - @tokens
      remaining_time = @time_period - (Time.now - @oldest_timestamp)
      
      if @tokens.zero?
        sleep(remaining_time) if remaining_time > 0
        reset_bucket
      elsif executed_this_period != 0
          delta_since_previous = Time.now - @before_previous_execution
          @total_task_time += delta_since_previous
          average_task_time = @total_task_time.to_f / executed_this_period
          throttle = (remaining_time.to_f + delta_since_previous) / (@tokens+1) - average_task_time
          sleep throttle if throttle > 0
      end
      
      @tokens -= 1
      @before_previous_execution = Time.now
    end
  end

end


