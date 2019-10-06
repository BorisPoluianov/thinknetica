require_relative './company.rb'

class Carriage
  include Company

  TYPES = [:cargo, :passenger].freeze

  attr_reader :type

  def initialize(type)
    @type = type.to_sym 
    validate!
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  private

  def validate!
    raise "Incorrect type of train: "\
          "train can be #{TYPES.join(' or ')}" unless TYPES.include? type
  end
end
