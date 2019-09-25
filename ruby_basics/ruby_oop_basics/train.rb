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
    @carriages_count += 1 if speed == 0
  end
  
  def remove_carriage 
    @carriages_count -= 1 if speed == 0
  end

  def set_route(given_route)
    @route = given_route
    station = @route.stations.first
    station.take_train(self)
    @current_station_index = 0 
  end

  def current_station
    @route.stations[current_station_index]
  end

  def next_station
    @route.stations[current_station_index + 1] unless current_station_index + 1 == @route.stations.size
  end

  def previous_station
    @route.stations[current_station_index - 1] unless current_station_index == 0
  end

  def move_forward
    if next_station != nil
      @route.stations[current_station_index].depart_train(self)
      @route.stations[current_station_index].take_train(self)
      @current_station_index += 1
    end
  end 

  def move_back
    if previous_station != nil
      @route.stations[current_station_index].depart_train(self)
      @route.stations[current_station_index].take_train(self)
      @current_station_index -= 1
    end
  end
end
