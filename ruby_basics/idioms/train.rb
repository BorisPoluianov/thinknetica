# frozen_string_literal: true

require_relative './company.rb'
require_relative './instance_counter.rb'

# Train class
class Train
  include Company
  include InstanceCounter

  TYPES = %i[cargo passenger].freeze
  NUMBER_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/.freeze

  @@trains = {}

  attr_writer :speed
  attr_reader :speed, :carriages, :current_station_index, :type, :train_id

  def self.trains
    @@trains
  end

  def self.find(train_id)
    @@trains[train_id]
  end

  def initialize(train_id, type)
    @speed = 0
    @train_id = train_id.to_s
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

  def add_carriage(carriage)
    return if speed.positive?

    @carriages.push(carriage) if carriage.type == type
  end

  def remove_carriage
    return if speed.positive? || carriages.empty?

    @carriages.pop
  end

  def give_route(given_route)
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
    return if current_station_index.zero?

    @route.stations[current_station_index - 1]
  end

  def move_forward
    return if next_station.nil?

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

  def every_car_at_the_train
    unless carriages.empty?
      if block_given?
        carriages.map.with_index(1) { |car, number| yield(car, number) }
      end
    end
  end

  private

  def validate!
    unless TYPES.include?(type)
      raise "Incorrect type of train: train can be #{TYPES.join(' or ')}"
    end
    raise 'Incorrect format of train id' if train_id !~ NUMBER_FORMAT
    raise 'This train id is already exist' if @@trains.key?(train_id)
  end
end
