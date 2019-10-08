require_relative './company.rb'

class Carriage
  include Company

  TYPES = [:cargo, :passenger].freeze

  attr_reader :type, :capacity

  def initialize(type, capacity)
    @type = type.to_sym 
    @capacity = capacity.to_i
    @occupied_capacity = 0
    validate!
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  def occupied_capacity
    @occupied_capacity
  end

  def free_capacity
    capacity - @occupied_capacity
  end

  def occupy_capacity(value)
    raise "Input capacity value is too big" if free_capacity < value
    @occupied_capacity += value unless free_capacity < value
  end

  private

  def validate!
    raise "Incorrect type of train: "\
          "train can be #{TYPES.join(' or ')}" unless TYPES.include? type
  end
end
