class Route
  attr_reader :route

  def initialize(start, finish)
    @route = []
    @route += [start, finish]
#    @route.each { |i| i = Station.new(i) }
#    @route += [{start: start}, {finish: finish}]
# or maybe like this: @route << {start: start} << {finish: finish} ?
  end

  def add_station(name)
    @route.insert(-2, name) unless @route.include?(name)
  end

  def delete_station(name)
      @route.delete(name) 
  end
end
