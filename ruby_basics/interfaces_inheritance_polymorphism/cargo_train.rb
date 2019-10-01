class CargoTrain < Train
  TYPE = :cargo

  def initialize(train_id)
    super(train_id, TYPE)
  end
end
