# frozen_string_literal: true

# Passenger carriage class
class PassengerCarriage < Carriage
  TYPE = :passenger

  def initialize(capacity)
    super(TYPE, capacity)
  end

  def occupy_capacity
    super(1)
  end
end
