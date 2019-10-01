class Route
  attr_reader :stations

  def initialize(start, finish)
    @start = start
    @finish = finish 
    @stations = [start, finish]
  end

  def add_station(station)
    return if stations.include?(station)
    @stations.insert(-2, station) 
  end

  def delete_station(station)
    return if [@start, @finish].include?(station)
    @stations.delete(station)
  end

  def to_s
    stations.each.with_index(1) do |station, index|
      puts "Station №#{index} - #{station.name.capitalize}"
    end
  end
end
