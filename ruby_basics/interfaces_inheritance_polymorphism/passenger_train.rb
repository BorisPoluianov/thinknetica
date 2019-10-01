class PassengerTrain < Train
  TYPE = :passenger
  
  def initialize(train_id) 
    super(train_id, TYPE)
  end
end
