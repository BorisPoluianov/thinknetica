# frozen_string_literal: true

# Cargo carriage class
class CargoCarriage < Carriage
  TYPE = :cargo

  def initialize(capacity)
    super(TYPE, capacity)
  end
end
