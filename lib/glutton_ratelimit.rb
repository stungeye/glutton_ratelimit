module GluttonRatelimit
  
  def limit_method symbol, executions, time_period, rl_class = AveragedThrottle
    rl = rl_class.new executions, time_period
    old_symbol = "#{symbol}_old".to_sym
    alias_method old_symbol, symbol
    define_method symbol do |*args|
      rl.wait
      self.send old_symbol, *args
    end
  end
  
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
