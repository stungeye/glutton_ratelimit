require 'rubygems'
require 'test/unit'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'glutton_ratelimit'

class Test::Unit::TestCase
end

def timed_run ratelimiter
  before_last_invocation = 0
  start_time = Time.now
  (ratelimiter.executions + 1).times do
    ratelimiter.wait
    before_last_invocation = Time.now
    yield
  end 
  before_last_invocation - start_time
end

