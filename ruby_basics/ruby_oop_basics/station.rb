class Station
  @@stations = {}

  attr_accessor :trains
  attr_reader :name, :train_id, :type

  def self.stations
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations[name.downcase.to_sym] = self
  end

  def take_train(train)
    self.trains += [train]
  end

  def depart_train(train)
    self.trains.delete(train)
  end

  def show_trains
    trains.map { |i| puts "Cargo - #{i.train_id}" if i.type == :cargo }
    trains.map { |i| puts "Passanger - #{i.train_id}" if i.type == :passenger }
  end
end
