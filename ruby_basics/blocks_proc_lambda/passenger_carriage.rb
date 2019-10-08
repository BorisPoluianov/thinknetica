class PassengerCarriage < Carriage
  TYPE = :passenger

  def initialize(seats)
    super(TYPE, seats)
  end

  def occupy_capacity
    super(1)
  end
end
