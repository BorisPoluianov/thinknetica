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
    self.train_length += 1 if speed == 0 && choice == 'add' 
    self.train_length -= 1 if speed == 0 && choice == 'remove'
  end

  def set(given_route)
    self.route = given_route.route
    self.name = route.first
    Station.stations[name.downcase.to_sym].take_train(itself)
  end

  def move(direction)
    direction = direction.to_sym
    if [ :forward, :back].include? direction
      Station.stations[name.downcase.to_sym].depart_train(self)
      self.name = where('next') if direction == :forward
      self.name = where('previous') if direction == :back
      self.speed = 50
    end
  end 

  def where(x)
    case x
    when 'now' 
      speed == 0 ? name : puts("Train is moving to #{name}")
    when 'next'
      route[route.index(name) + 1] 
    when 'previous'
      route[route.index(name) - 1] 
    end
  end
end
