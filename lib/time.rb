
class Intervals

  attr_reader: 

  def initialize(times)
    @times = times.sort
    @new_times = []
    @free_time = []
    @prev_pair = []
  end

  def free_time
    sort_intervals
    @prev_pair = []
    @new_times.each do |el| 
      slice_time(el)
    end
    @free_time
  end

  def sort_intervals
    @times.each do |i|
      compare(i)
    end
    @new_times.push(@prev_pair)
  end

  private

  def slice_time(el)
    @prev_pair.empty? ? @prev_pair = el : slice(el)
  end

  def slice(el)
    @free_time.push([@prev_pair[1], el[0]])
    @prev_pair = el
  end

  def compare(element)
    @prev_pair.empty? ? @prev_pair = element : add_new(element)
  end

  def add_new(element)
    if @prev_pair[1] >= element[0]
      @prev_pair = [@prev_pair[0], element[1]]
      @prev_pair
    else
      @new_times.push(@prev_pair)
      @prev_pair = element
    end
  end
end

arr = [['10:00', '10:20'], ['12:00', '13:00'], ['10:40', '11:00'], ['11:00', '12:00'], ['13:30', '18:20'], ['10:00', '10:20']]
result = Intervals.new(arr)
p result.free_time
