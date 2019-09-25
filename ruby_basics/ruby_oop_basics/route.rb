class Route
  attr_reader :stations


  def initialize(start, finish)
    @stations = []
    @start = start
    @finish = finish 
    @stations += [start, finish]
  end

  def add_station(name)
    self.stations.insert(-2, name) unless stations.include?(name)
  end

  def delete_station(name)
    self.stations.delete(name) unless [@start, @finish].include?(name)
  end

  def to_s
    stations.each.with_index(1) do |station, index|
      puts "Station №#{index} - #{station.name.capitalize}"
    end
  end
end
