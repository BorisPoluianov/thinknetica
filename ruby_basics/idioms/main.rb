# frozen_string_literal: true

require_relative './station.rb'
require_relative './route.rb'
require_relative './train.rb'
require_relative './passenger_train.rb'
require_relative './cargo_train.rb'
require_relative './carriage.rb'
require_relative './passenger_carriage.rb'
require_relative './cargo_carriage.rb'

# Main class
class Main
  def initialize
    @all_stations = []
    @all_trains = []
    @all_routes = []
  end

  def run
    loop do
      output(bd: main_menu, ttl: 'Main menu')
      choice = gets.to_i

      break if choice.zero?

      menu_options(choice)
    end
  end

  private

  def menu_options(choice)
    case choice
    when 1 then create_station
    when 2 then create_train
    when 3 then create_route
    when 4 then modify_route
    when 5 then give_route
    when 6 then add_carriage
    when 7 then occupy_car_capacity
    when 8 then remove_carriage
    when 9 then move_train
    when 10 then list_trains_with_cars
    when 11 then list_stations_and_trains_on_it
    when 12 then load_test_data
    when 13 then list_all_railway
    end
  end

  def test_data
    {
      stations_names: %w[berlin rome zurich paris],
      trains_params: [[PassengerTrain, '123-23'], [CargoTrain, '321-32'], [PassengerTrain, '432-44']],
      routes_params: [[1, 2], [2, 3], [3, 4]],
      carriage_count: rand(3..7),
      cargo: 15_000,
      passenger: 84
    }
  end

  def load_test_data
    test_data.fetch(:stations_names).each { |station_name| create_station { station_name } }
    test_data.fetch(:routes_params).each { |route_params| create_route { route_params } }
    test_data.fetch(:trains_params).each { |train_params| create_train { train_params } }
    test_data.fetch(:routes_params).size.times { |index| give_route { index } }
    @all_trains.each do |train|
      test_data.fetch(:carriage_count).times { add_carriage { [train, test_data[train.type]] } }
    end
  end

  def list(args = {})
    args.fetch(:from).map.with_index(1) do |unit, number|
      case args.fetch(:what)
      when :stations then "#{number} - #{unit.name.capitalize}"
      when :routes then "#{number} - #{unit.stations.map(&:name)}"
      when :trains then "#{number} - id:#{unit.train_id} - #{unit.type} - cars:#{unit.carriages.size} \n"
      when :cars
        unit.every_car_at_the_train do |car, number|
          "car № #{number} - #{car.type} - capacity: #{car.capacity} -"\
          " occupied: #{car.occupied_capacity} - free: #{car.free_capacity} "
        end
      end
    end
  end

  def list_all_railway
    @all_stations.map do |station|
      puts "\t\t#{station.name.capitalize}"
      station.every_train_at_the_station do |train|
        puts "#{train.train_id} - #{train.type} -  cars: #{train.carriages.size}"
        train.every_car_at_the_train do |car, number|
          puts "  № #{number} - #{car.type} - free: #{car.free_capacity}"\
               " - occupied: #{car.occupied_capacity}"
        end
      end
    end
  end

  def list_trains_with_cars
    @all_trains.each do |train|
      output(bd: list(what: :cars, from: [train]), ttl: list(what: :trains, from: [train]))
    end
  end

  def create_station
    if block_given?
      name = yield
    else
      output(msg: 'Enter station name:', ttl: 'New station menu')
      name = gets.chomp
    end
    @all_stations << Station.new(name)
  rescue RuntimeError => e
    output(msg: e.message, ttl: 'Error')
    retry
  else
    output(msg: "#{name.capitalize} station was created", ttl: 'Object was created')
  end

  def create_train
    if block_given?
      train, train_id = yield
    else
      output(msg: 'Type <1> for passenger and <2> for cargo train:', ttl: 'New train menu')
      selected_type = gets.to_i
      output(msg: 'Type train id:')
      train_id = gets.chomp
      train = { 1 => PassengerTrain, 2 => CargoTrain }.fetch(selected_type)
    end
    @all_trains << train.new(train_id)
  rescue RuntimeError => e
    output(msg: e.message, ttl: 'Error')
    retry
  else
    output(msg: "№ #{train_id} - #{@all_trains.last.type} train was created",
           ttl: 'Object was created')
  end

  def create_route
    if block_given?
      start_number, end_number = yield
    else
      output(bd: list(what: :stations, from: @all_stations), ttl: 'Stations list',
             msg: 'Type number of start and end station')
      start_number = gets.to_i
      end_number = gets.to_i
    end
    @all_routes << Route.new(@all_stations[start_number - 1], @all_stations[end_number - 1])
  rescue RuntimeError => e
    output(msg: e.message, ttl: 'Error')
    retry
  else
    output(msg: "Route from #{@all_routes.last.stations.first.name.capitalize} to "\
                "#{@all_routes.last.stations.last.name.capitalize} was created",
           ttl: 'Object was created')
  end

  def modify_route
    output(bd: list(what: :routes, from: @all_routes), ttl: 'Routes list',
           msg: 'Type route number to edit. Then type <1> to add station and <2> to remove')
    selected_route_number = gets.to_i
    selected_route = @all_routes[selected_route_number - 1]
    selected_modify_action = gets.to_i
    case selected_modify_action
    when 1 then add_route(selected_route)
    when 2 then remove_route(selected_route)
    end
  end

  def add_route(selected_route)
    output(bd: list(what: :stations, from: @all_stations), ttl: 'Stations list',
           msg: 'Type number of station ot add:')
    selected_station_number = gets.to_i
    selected_route.add_station @all_stations[selected_station_number - 1]
  end

  def remove_route(selected_route)
    output(bd: list(what: :stations, from: @all_stations), ttl: 'Stations list',
           msg: 'Type number of station to remove:')
    selected_station_number = gets.to_i
    selected_station = selected_route.stations[selected_station_number - 1]
    selected_route.delete_station(selected_station)
  end

  def give_route
    if block_given?
      selected_route_number = yield
      selected_train_number = yield
    else
      output(bd: list(what: :routes, from: @all_routes), ttl: 'Routes list', msg: 'Type number')
      selected_route_number = gets.to_i
      output(bd: list(what: :trains, from: @all_trains), ttl: 'Trains list', msg: 'Type number')
      selected_train_number = gets.to_i
    end
    selected_train = @all_trains[selected_train_number - 1]
    selected_route = @all_routes[selected_route_number - 1]
    selected_train.give_route(selected_route)
    output(msg: 'Route was given')
  end

  def add_carriage
    if block_given?
      train, capacity_number = yield
    else
      output(bd: list(what: :trains, from: @all_trains), ttl: 'Trains list',
             msg: 'Type number of train. Then type carriage capacity number')
      selected_train_number = gets.to_i
      capacity_number = gets.to_i
      train = @all_trains[selected_train_number - 1]
    end
    carriage = { passenger: PassengerCarriage, cargo: CargoCarriage }.fetch(train.type)
    train.add_carriage(carriage.new(capacity_number))
  rescue RuntimeError => e
    output(msg: e.message, ttl: 'Error')
    retry
  else
    output(msg: 'Carriage was added')
  end

  def occupy_car_capacity
    output(bd: list(what: :trains, from: @all_trains), ttl: 'Trains list',
           msg: 'Type number of train')
    train_number = gets.to_i
    train = @all_trains[train_number - 1]
    output(bd: list(what: :cars, from: [train]), ttl: 'Train cars list',
           msg: 'Type carriage number then capacity')
    carriage_number = gets.to_i
    capacity_value = gets.to_i
    train.carriages[carriage_number - 1].occupy_capacity(capacity_value)
  rescue RuntimeError => e
    output(msg: e.message, ttl: 'Error')
    retry
  else
    output(bd: list(what: :cars, from: [train]), ttl: 'Carriage capacity was changed')
  end

  def remove_carriage
    output(bd: list(what: :trains, from: @all_trains), ttl: 'Trains list',
           msg: 'Type number of train')
    selected_train_number = gets.to_i
    selected_train = @all_trains[selected_train_number - 1]
    selected_train.remove_carriage
    output(msg: 'Carriage was removed')
  end

  def move_train
    output(bd: list(what: :trains, from: @all_trains), ttl: 'Trains list',
           msg: 'Type number of train')
    selected_train_number = gets.to_i
    selected_train = @all_trains[selected_train_number - 1]
    output(msg: 'Type <1> to move forward and <2> to move backward')
    case gets.to_i
    when 1 then selected_train.move_forward
    when 2 then selected_train.move_backward
    end
  end

  def list_stations_and_trains_on_it
    output(bd: list(what: :stations, from: @all_stations), ttl: 'Stations list',
           msg: 'Type number of station')
    selected_station_number = gets.to_i
    selected_station = @all_stations[selected_station_number - 1]
    output(bd: list(what: :trains, from: selected_station.trains),
           ttl: "Trains on #{selected_station.name.capitalize}")
  end

  #####
  # Output methods
  #####

  def output(content = {})
    print ' - ' * 15 + "\n\t\t"
    puts content[:ttl] unless content[:ttl].nil?
    content[:bd]&.each { |text| puts text }
    puts content[:msg] unless content[:msg].nil?
  end

  def main_menu
    ['0 - Exit the program',
     '1 - Create station',
     '2 - Create train',
     '3 - Create  route',
     '4 - Modify route',
     '5 - Set route to the train',
     '6 - Add carriage to the train',
     '7 - Occupy carriage capacity',
     '8 - Remove carriage from the train',
     '9 - Move train between stations',
     '10 - List train cars info',
     '11 - Display stations list and trains on them.',
     '12 - Load test data',
     '13 - List ALL RAILWAY',
     'Type number for action...']
  end
end

railway = Main.new
railway.run
