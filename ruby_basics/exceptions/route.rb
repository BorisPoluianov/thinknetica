require_relative './instance_counter.rb'

class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(start, finish)
    @start = start
    @finish = finish 
    @stations = [start, finish]
    validate!
    register_instance
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
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

  private

  def validate!
    raise 'Incorrect class of entered object(s)' unless stations.all? { |station| station.instance_of? Station }
  end
end
