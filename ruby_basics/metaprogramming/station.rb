# frozen_string_literal: true

require_relative './instance_counter.rb'
require_relative './validation.rb'

# Station class
class Station
  include InstanceCounter
  include Validation

  @stations = []

  attr_reader :name, :trains

  validate :name, :presence
  validate :name, :type, String

  def self.all
    @stations
  end

  def self.all_add(station)
    @stations << station
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    Station.all_add(self)
    register_instance
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
end
