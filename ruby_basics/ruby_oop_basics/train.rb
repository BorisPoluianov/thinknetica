class Train
  TYPES = [ :cargo, :passenger]

  attr_accessor :speed, :train_length, :route, :name
  attr_reader :train_id, :type

  def initialize(type, train_length)
    @speed = 0
    @train_id = rand(100..1000)
    @type = type.to_sym if TYPES.include?(type.to_sym)
    @train_length = train_length
  end

  def change_train_length(choice)
    if speed == 0 && choice == 'add' 
      self.train_length += 1
    elsif speed == 0 && choice == 'remove'
      self.train_length -= 1
    end 
  end

  def set(given_route)
    self.route = given_route.route
    self.name = route.first
    Station.stations[name.downcase.to_sym].take_train(itself)
  end

  def move(direction)
    Station.stations[name.downcase.to_sym].depart_train(itself)
    if direction == 'forward'
      self.name = status('next')
    elsif direction == 'back'
      self.name = status('previous')
    end  
    self.speed = 50
  end 

  def status(x)
    case x
    when 'now' 
      if speed == 0 
        name 
      else
        puts "Train is moving to #{name}"
      end
    when 'next'
      route[route.index(name) + 1]
    when 'back'
      route[route.index(name) - 1]
    end
  end
end
