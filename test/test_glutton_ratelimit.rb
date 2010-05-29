require 'helper'

class TestGluttonRatelimit < Test::Unit::TestCase
  def test_object_creations
    rl = GluttonRatelimit.new 1, 1
    assert_instance_of GluttonRatelimit, rl
  end
  
  def test_120_tasks_every_second_with_ms_task
    min_time = 1
    delta = timed_run(120, min_time) {sleep 0.001}
    assert delta > min_time
  end
  
  def test_120_tasks_every_second_with_cenisecond_task
    min_time = 1
    delta = timed_run(120, min_time) {sleep 0.01}
    assert delta > min_time
  end
  
  def test_1_task_every_2_seconds_with_ms_task
    min_time = 2
    delta = timed_run(1, min_time) {sleep 0.001}
    assert delta > min_time
  end
  
  def test_1_task_every_2_seconds_with_2_second_task
    min_time = 2
    delta = timed_run(1, min_time) {sleep 2}
    #puts "#{delta} expected > #{min_time}"
    assert delta > min_time
  end
end
