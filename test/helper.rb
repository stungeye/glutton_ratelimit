require 'rubygems'
require 'test/unit'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'glutton_ratelimit'

class Test::Unit::TestCase
end

def tenth_of_second
  sleep 0.1
end

def half_of_second
  sleep 0.5
end

def one_second
  sleep 1
end

def timed_run max_executions, time_period
  rl = GluttonRatelimit.new max_executions, time_period
  before_last_invocation = 0
  start_time = Time.now
  (max_executions + 1).times do
    rl.wait
    before_last_invocation = Time.now
    yield
  end 
  before_last_invocation - start_time
end

