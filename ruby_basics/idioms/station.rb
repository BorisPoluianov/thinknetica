# frozen_string_literal: true

require_relative './instance_counter'

# Station class
class Station
  include InstanceCounter

  @stations = []

  attr_reader :name, :trains

  def self.all
    @stations
  end

  def self.all_add(station)
    @stations << station
  end

  def initialize(name)
    @name = name.chomp.to_s
    @trains = []
    validate!
    Station.all_add(self)
    register_instance
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  def take_train(train)
    @trains.push(train)
  end

  def depart_train(train)
    @trains.delete(train)
  end

  def trains_by_type(type)
    trains.select { |train| train.type == type.to_sym }.size
  end

  def every_train_at_the_station
    trains.map { |train| yield(train) } if block_given?
  end

  private

  def validate!
    raise 'Station name is empty' if name.empty?
    return unless Station.all.any? { |station| station.name == name }

    raise 'This station name is already exist'
  end
end
