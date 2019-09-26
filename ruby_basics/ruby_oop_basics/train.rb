class Train
  TYPES = [ :cargo, :passenger]

  attr_reader :speed, :carriages_count, :current_station_index, :type


  def initialize(train_id, type, carriages_count)
    @speed = 0
    @train_id = train_id
    @type = type.to_sym if TYPES.include?(type.to_sym)
    @carriages_count = carriages_count
  end

  def brake
    @speed = 0
  end
 
  def add_carriage
    return if speed > 0
    @carriages_count += 1
  end
  
  def remove_carriage 
    return if  speed > 0 || carriages_count == 0 
    @carriages_count -= 1
  end

  def set_route(given_route)
    @route = given_route
    @current_station_index = 0 
    current_station.take_train(self)
  end

  def current_station
    @route.stations[current_station_index]
  end

  def next_station
    return if current_station_index + 1 == @route.stations.size
    @route.stations[current_station_index + 1]
  end

  def previous_station
    return if current_station_index == 0
    @route.stations[current_station_index - 1]
  end

  def move_forward
    return if  next_station.nil?
    current_station.depart_train(self)
    next_station.take_train(self)
    @current_station_index += 1
  end 

  def move_back
    return if previous_station.nil?
    current_station.depart_train(self)
    previous_station.take_train(self)
    @current_station_index -= 1
  end
end
