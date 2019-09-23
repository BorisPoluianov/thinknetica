class Route
  attr_accessor :route

  def initialize(start, finish)
    @route = []
    @route += [start, finish]
  end

  def add_station(name)
    route.insert(-2, name) unless route.include?(name)
  end

  def delete_station(name)
    route.delete(name) 
  end

  def route
    @route.each { |i| puts i }
  end
end
