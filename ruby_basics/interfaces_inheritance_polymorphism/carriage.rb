class Carriage
  TYPES = [:cargo, :passenger].freeze

  attr_reader :type

  def initialize(type)
    @type = type.to_sym if TYPES.include? type.to_sym
  end
end
