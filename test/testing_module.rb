module TestingModule
  # This module assumes use as a mixin within
  # a test class which defines @testClass.
  
  def test_120_tasks_every_second_with_ms_task
    min_time = 1
    rl = @testClass.new 120, min_time
    delta = timed_run(rl) {sleep 0.001}
    puts "#{delta} >? #{min_time}"
    assert delta > min_time
  end

  def test_120_tasks_every_quarter_second_with_ms_task
    min_time = 0.25
    rl = @testClass.new 120, min_time
    delta = timed_run(rl) {sleep 0.001}
    puts "#{delta} >? #{min_time}"
    assert delta > min_time
  end
  
  def test_120_tasks_every_second_with_cenisecond_task
    min_time = 1
    rl = @testClass.new 120, min_time
    delta = timed_run(rl) {sleep 0.01}
    puts "#{delta} >? #{min_time}"
    assert delta > min_time
  end
  
  def test_50_tasks_every_second_with_fast_task
    min_time = 1
    rl = @testClass.new 50, min_time
    delta = timed_run(rl) {sleep 0}
    puts "#{delta} >? #{min_time}"
    assert delta > min_time
  end
  
  def test_1_task_every_2_seconds_with_ms_task
    min_time = 2
    rl = @testClass.new 1, min_time
    delta = timed_run(rl) {sleep 0.001}
    puts "#{delta} >? #{min_time}"
    assert delta > min_time
  end
  
  def test_1_task_every_2_seconds_with_2_second_task
    min_time = 2
    rl = @testClass.new 1, min_time
    delta = timed_run(rl) {sleep 2}
    puts "#{delta} >? #{min_time}"
    assert delta > min_time
  end
end
