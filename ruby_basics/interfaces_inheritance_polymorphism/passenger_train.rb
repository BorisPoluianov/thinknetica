class PassengerTrain < Train
  def initialize(train_id) 
    super(train_id, :passenger)
  end

  def add_carriage(carriage)
    super(carriage) if carriage.class == PassengerCarriage
  end
end
