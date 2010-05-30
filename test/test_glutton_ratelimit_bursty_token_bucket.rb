require 'helper'
require 'testing_module.rb'

class TestGluttonRatelimitBurtyTokenBucket < Test::Unit::TestCase
  include TestingModule
  
  def setup
    @testClass = GluttonRatelimit::BurstyTokenBucket
  end
  
  def test_object_creations
    rl = @testClass.new 1, 1
    assert_instance_of GluttonRatelimit::BurstyTokenBucket, rl
  end
end
