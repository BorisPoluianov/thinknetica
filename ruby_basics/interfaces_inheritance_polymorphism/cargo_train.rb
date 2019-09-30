class CargoTrain < Train
  def initialize(train_id)
    super(train_id, :cargo)
  end

  def add_carriage(carriage)
    super(carriage) if carriage.class == CargoCarriage
  end
end
