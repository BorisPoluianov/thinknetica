class Station
  attr_reader :name, :trains


  def initialize(name)
    @name = name
    @trains = []
  end

  def take_train(train)
    @trains.push(train)
  end

  def depart_train(train)
    @trains.delete(train)
  end

  def trains_by_type(type)
    trains.select { |index| index.type == type.to_sym }.size
  end
end
