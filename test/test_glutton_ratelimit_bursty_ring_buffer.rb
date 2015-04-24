require 'helper'
require 'testing_module.rb'

class TestGluttonRatelimitBurstyRingBuffer < Test::Unit::TestCase
  include TestingModule # All the shared tests are in here.
  
  def setup
    @testClass = GluttonRatelimit::BurstyRingBuffer
  end
  
  def test_object_creations
    rl = @testClass.new 1, 1
    assert_instance_of GluttonRatelimit::BurstyRingBuffer, rl
  end
end
