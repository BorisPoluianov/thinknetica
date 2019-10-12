# frozen_string_literal: true

require_relative './company.rb'

# Class Carriage
class Carriage
  include Company

  CAR_TYPES = %i[cargo passenger].freeze

  attr_reader :type, :capacity, :occupied_capacity

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

  def free_capacity
    capacity - @occupied_capacity
  end

  def occupy_capacity(value)
    raise 'Input capacity value is too big' if free_capacity < value

    @occupied_capacity += value unless free_capacity < value
  end

  private

  def validate!
    if CAR_TYPES.none?(type)
      raise "Incorrect type of carriage: carriage can be #{CAR_TYPES.join(' or ')}"
    end
  end
end
