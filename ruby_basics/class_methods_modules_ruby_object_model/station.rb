require_relative './instance_counter'

class Station
  include InstanceCounter

  @@stations = []

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    @@stations += [self]
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
end
