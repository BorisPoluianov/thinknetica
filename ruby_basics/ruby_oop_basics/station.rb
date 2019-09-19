class Station
  attr_reader :name, :train_id, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def take_train(train_id)
    @trains += train_id.self
  end

  def depart_train(train_id)
    @trains.delete(train_id.self)
  end

  def show_trains
   @trains.map { |i| i[type] = :cargo }
   @trains.map { |i| i[type] = :passenger }
  end
end
