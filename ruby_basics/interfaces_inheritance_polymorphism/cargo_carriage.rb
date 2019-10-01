class CargoCarriage
  TYPE = :cargo
  TYPE.freeze  

  attr_reader :type

  def initialize
    @type = TYPE
  end
end
