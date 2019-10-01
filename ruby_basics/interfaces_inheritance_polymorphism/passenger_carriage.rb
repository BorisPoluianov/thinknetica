class PassengerCarriage < Carriage
  TYPE = :passenger

  def initialize
    super(TYPE)
  end
end
