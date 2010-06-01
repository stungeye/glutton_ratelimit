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
end

dir = File.expand_path(File.dirname(__FILE__))
require File.join(dir, "glutton_ratelimit", "bursty_ring_buffer")
require File.join(dir, "glutton_ratelimit", "bursty_token_bucket")
require File.join(dir, "glutton_ratelimit", "averaged_throttle")
