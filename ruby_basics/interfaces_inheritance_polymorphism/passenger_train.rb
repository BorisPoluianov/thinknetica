class PassengerTrain < Train
  TYPE = Train::TYPES[1]
  TYPE.freeze
  
  def initialize(train_id) 
    super(train_id, TYPE)
  end

  def add_carriage(carriage)
    super(carriage) if carriage.type == TYPE
  end
end
