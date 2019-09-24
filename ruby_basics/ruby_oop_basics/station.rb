class Station
  @@stations = {}

  attr_accessor :trains
  attr_reader :name, :type


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
    cargo = 0
    passenger = 0
    trains.each do |i|
      i.type == :cargo ? cargo += 1 : passenger += 1
    end
    puts "Cargo trains number = #{cargo}"
    puts "Passenger trains number = #{passenger}"
  end
end
