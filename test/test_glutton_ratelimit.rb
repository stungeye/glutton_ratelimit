require 'helper'

class TestGluttonRatelimit < Test::Unit::TestCase
  def test_object_creations
    rl = GluttonRatelimit.new 1, 1
    assert_instance_of GluttonRatelimit, rl
  end
  
  def test_120_tasks_every_second_with_ms_task
    min_time = 1
    rl = GluttonRatelimit.new 120, min_time
    delta = timed_run(rl) {sleep 0.001}
    assert delta > min_time
  end

  def test_120_tasks_every_quarter_second_with_ms_task
    min_time = 0.25
    rl = GluttonRatelimit.new 120, min_time
    delta = timed_run(rl) {sleep 0.001}
    assert delta > min_time
  end
  
  def test_120_tasks_every_second_with_cenisecond_task
    min_time = 1
    rl = GluttonRatelimit.new 120, min_time
    delta = timed_run(rl) {sleep 0.01}
    assert delta > min_time
  end
  
  def test_50_tasks_every_second_with_fast_task
    min_time = 1
    rl = GluttonRatelimit.new 50, min_time
    delta = timed_run(rl) {sleep 0}
    assert delta > min_time
  end
  
  def test_1_task_every_2_seconds_with_ms_task
    min_time = 2
    rl = GluttonRatelimit.new 1, min_time
    delta = timed_run(rl) {sleep 0.001}
    assert delta > min_time
  end
  
  def test_1_task_every_2_seconds_with_2_second_task
    min_time = 2
    rl = GluttonRatelimit.new 1, min_time
    delta = timed_run(rl) {sleep 2}
    #puts "#{delta} >? #{min_time}"
    assert delta > min_time
  end
end
