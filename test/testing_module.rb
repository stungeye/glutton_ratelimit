module TestingModule
  # This module assumes use as a mixin within
  # a test class which defines @testClass.

  TIMING_TOLERANCE = 0.995 # Timing can be off by 0.5%

  def test_120_tasks_every_second_with_ms_task
    min_time = 1
    rl = @testClass.new 120, min_time
    delta = timed_run(rl) { sleep 0.001 }
    # puts "\n#{delta} >? #{min_time}"
    assert((delta / min_time) > TIMING_TOLERANCE)
  end

  def test_120_tasks_every_quarter_second_with_ms_task
    min_time = 0.25
    rl = @testClass.new 120, min_time
    delta = timed_run(rl) { sleep 0.001 }
    # puts "\n#{delta} >? #{min_time}"
    assert((delta / min_time) > TIMING_TOLERANCE)
  end

  def test_120_tasks_every_second_with_cenisecond_task
    min_time = 1
    rl = @testClass.new 120, min_time
    delta = timed_run(rl) { sleep 0.01 }
    # puts "\n#{delta} >? #{min_time}"
    assert((delta / min_time) > TIMING_TOLERANCE)
  end

  def test_50_tasks_every_second_with_no_task
    min_time = 1
    rl = @testClass.new 50, min_time
    delta = timed_run(rl) { sleep 0 }
    # puts "\n#{delta} >? #{min_time}"
    assert((delta / min_time) > TIMING_TOLERANCE)
  end

  def test_1_task_every_1_seconds_with_1_second_task
    min_time = 1
    rl = @testClass.new 1, min_time
    delta = timed_run(rl) { sleep 1 }
    # puts "\n#{delta} >? #{min_time}"
    assert((delta / min_time) > TIMING_TOLERANCE)
  end

  def test_5_tasks_every_quarter_second_four_runs_with_ms_task
    min_time = 0.25
    runs = 4
    rl = @testClass.new 1, min_time
    delta = timed_run(rl, runs) { sleep 0.001 }
    # puts "\n#{delta} >? #{min_time * runs}"
    assert((delta / (min_time * runs)) > TIMING_TOLERANCE)
  end

  def test_120_tasks_every_half_second_two_runs_with_no_task
    min_time = 0.5
    runs = 2
    rl = @testClass.new 120, min_time
    delta = timed_run(rl, 2) { sleep 0 }
    # puts "\n#{delta} >? #{min_time * runs}"
    assert((delta / (min_time * runs)) > TIMING_TOLERANCE)
  end

  def test_10_tasks_every_1_seconds_two_runs_with_short_rnd_task
    min_time = 1
    runs = 2
    rl = @testClass.new 10, min_time
    delta = timed_run(rl, 2) { sleep(0.2 * rand) }
    # puts "\n#{delta} >? #{min_time * runs}"
    assert((delta / (min_time * runs)) > TIMING_TOLERANCE)
  end
end
