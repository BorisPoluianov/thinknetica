class CargoCarriage < Carriage
  TYPE = :cargo

  def initialize
    super(TYPE)
  end
end
