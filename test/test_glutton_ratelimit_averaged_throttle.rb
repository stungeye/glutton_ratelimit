require 'helper'
require 'testing_module.rb'

class TestGluttonRatelimitAveragedThrottle < Test::Unit::TestCase
  include TestingModule
  
  def setup
    @testClass = GluttonRatelimit::AveragedThrottle
  end
  
  def test_object_creations
    rl = @testClass.new 1, 1
    assert_instance_of GluttonRatelimit::AveragedThrottle, rl
  end
end
