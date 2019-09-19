class Train
  TYPES = [ :cargo, :passenger]

  attr_accessor :speed 
  attr_reader :name, :route, :train_id, :train_length

  def initialize(type, train_length)
    @speed = 0
    @train_id = rand(100..1000)
    @type = type.to_sym if TYPES.include?(type.to_sym)
    @train_length = train_length
  end

  def change_train_length(choice)
    if @speed == 0 && choice == 'add' 
      @train_length += 1
    elsif @speed == 0 && choice == 'remove'
      @train_length -= 1
    end 
  end

  def set(route)
    @route = route
    @name = @route.route.first
  end

  def move(direction)
    if @speed > 0 && direction == 'forward' 
    

end
