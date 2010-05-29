class GluttonRatelimit
  
  class UnknownTimestampSelected < StandardError; end
  
  def initialize executions, time_period
    @executions = executions
    @time_period = time_period
    
    @timestamps = Array.new executions, (Time.now - time_period)
    @timestamps_position = 0
  end
  
  def oldest_timestamp
    fetch_position = @timestamps_position + 1
    fetch_position = 0 if fetch_position == @timestamps.size
    @timestamps[fetch_position]
  end
  
  def current_timestamp= new_stamp
    @timestamps_position += 1
    @timestamps_position = 0 if @timestamps_position == @timestamps.size
    @timestamps[@timestamps_position] = new_stamp
  end
    
  def wait
    delta = Time.now - oldest_timestamp
    sleep(@time_period - delta) if delta < @time_period
    current_time = Time.now
    self.current_timestamp = Time.now
  end
end


number = 6
rt = GluttonRatelimit.new number, 12

start_time = Time.now
counter = 0

while true
  rt.wait
  current_time = Time.now
  elapsed = current_time - start_time
  counter += 1
  puts "#{counter} : #{elapsed}"
  sleep 1.5
  
end
