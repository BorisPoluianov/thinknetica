class PassengerCarriage
  TYPE = :passenger
  TYPE.freeze

  attr_reader :type

  def initialize
    @type = TYPE
  end
end
