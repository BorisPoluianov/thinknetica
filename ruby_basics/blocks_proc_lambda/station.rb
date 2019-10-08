require_relative './instance_counter'

class Station
  include InstanceCounter

  @@stations = []

  attr_reader :name, :trains

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
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
    yield.trains.map { |train| train } if block_given?
  end

  private

  def validate!
    raise 'Station name is empty' if name.empty?
    raise 'This station name is already exist' unless @@stations.none? { |station| station.name == name }
  end
end
