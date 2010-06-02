module GluttonRatelimit
  
  class BurstyTokenBucket < ParentLimiter
    
    def reset_bucket
      @oldest_timestamp = Time.now
      @tokens = @executions
    end
    
    def wait
      reset_bucket if @tokens.nil?
      if @tokens.zero?
        delta = Time.now - @oldest_timestamp
        sleep(@time_period - delta) if delta < @time_period
        reset_bucket
      end
      @tokens -= 1
    end
    
  end

end


