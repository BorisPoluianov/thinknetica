require_relative './company.rb'
require_relative './instance_counter.rb'

class Train
  include Company
  include InstanceCounter

  TYPES = [:cargo, :passenger].freeze
  NUMBER_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/

  @@trains = {}

  attr_reader :speed, :carriages, :current_station_index, :type, :train_id

  def self.trains
    @@trains
  end

  def self.find(train_id)
    @@trains[train_id]
  end

  def initialize(train_id, type)
    @speed = 0
    @train_id = train_id
    @carriages = []
    @type = type.to_sym
    validate!
    @@trains[train_id] = self
    register_instance
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  def brake
    @speed = 0
  end

  def speed=(value)
    @speed = value
  end

  def add_carriage(carriage)
    return if speed > 0
    @carriages.push(carriage) if carriage.type == self.type
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

  private

  def validate!
    raise "Incorrect type of train: "\
          "train can be #{TYPES.join(' or ')}" unless TYPES.include?(type)
    raise 'Incorrect format of train id' if train_id !~ NUMBER_FORMAT
    raise 'This train id is already exist' if @@trains.has_key?(train_id)
  end
end
