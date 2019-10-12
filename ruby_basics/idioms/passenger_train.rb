# frozen_string_literal: true

# Passenger train class
class PassengerTrain < Train
  TYPE = :passenger

  def initialize(train_id)
    super(train_id, TYPE)
  end
end
