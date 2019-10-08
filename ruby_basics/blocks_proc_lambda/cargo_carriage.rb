class CargoCarriage < Carriage
  TYPE = :cargo

  def initialize(volume)
    super(TYPE, volume)
  end
end
