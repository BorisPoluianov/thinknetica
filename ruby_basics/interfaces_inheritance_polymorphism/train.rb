class Train
  TYPES = [ :cargo, :passenger]

  attr_reader :speed, :carriages, :current_station_index, :type, :train_id


  def initialize(train_id, type)
    @speed = 0
    @train_id = train_id
    @carriages = []
    @type = type.to_sym if TYPES.include? type.to_sym
  end

  def brake
    @speed = 0
  end

  def speed=(value)
    @speed = value
  end

  def add_carriage(carriage)
    return if speed > 0
    @carriages.push(carriage)
  end
  
  def remove_carriage
    return if  speed > 0 || carriages.size == 0 
    @carriages.pop
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

  def move_backward
    return if previous_station.nil?
    current_station.depart_train(self)
    previous_station.take_train(self)
    @current_station_index -= 1
  end
end
